class LinksController < ApplicationController
  before_action :set_link, only: %i[ show edit update destroy ]
  before_action :authorize_user!, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[redirect_original_url private_link_authentication]

  # GET /links 
  def index
  """
  Show all the links of the current user paginated
  """
    @links = current_user.links.paginate(page: params[:page], per_page: 5)
  end

  # GET /links/1
  def show
  """
  Show the details of a link (url, shortlink, link type, expiration date, password, and reports)
  """
    @link = Link.find(params[:id])
    @short = redirect_original_url_url(@link.slug) 
  end

  # GET /links/new
  def new
  """
  Show the form to create a new link
  """  
    @link = Link.new
  end

  # POST /links
  def create
  """
  Create a new link
  """
    @link = current_user.links.build(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to link_url(@link), notice: "The link was successfully created." }
        # format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  def update
  """
  Update a link
  """
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to link_url(@link), notice: "The link was successfully updated." }
        # format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  def destroy
  """
  Delete a link
  """
    @link.destroy!
    respond_to do |format|
      format.html { redirect_to links_url, notice: "The link was successfully deleted." }
    end
  end

# GET /links/:slug
def redirect_original_url
"""
Redirect to the original url of the link depending on the link type. 
If the link is private, it renders a html form to enter the password.
"""
  @link = Link.find_by(slug: params[:slug])
  if @link.present?
    case @link.link_type
    when 'private'
      #Renders a html form to enter the password
      render 'private_link_password_view'
    when 'temporary'
      redirect_temporary_link
    when 'ephemeral'
      redirect_ephemeral_link
    else
      redirect_regular_link
    end
  else
    flash[:alert] = 'The Link doesn´t exist'
    redirect_to root_path
  end
end

# POST /links/:slug
def private_link_authentication
"""
Redirect to the original url of the link if the password is correct.
"""
  @link = Link.find_by(slug: params[:slug])

  if @link.present? && @link.authenticate(params[:password])
    Visit.create_visit(@link, current_time, request.remote_ip)
    redirect_to @link.url, allow_other_host: true
  else
    flash[:alert] = 'Password is incorrect. Please enter the correct password'
    render 'private_link_password_view'
  end
end

# GET /links/:id/visits
def visit_detail
  """ 
  All the visits of a link are shown with the IP address and datetime of the visit.
  Also there is a search engine to filter by IP address and datetime range.
  """
    @link = Link.find(params[:id]) 
    @q = @link.visits.ransack(params[:q])
    @visits_paginated = @q.result.paginate(page: params[:page], per_page: 6)
end
  

def visit_counter_chart
  """ 
  The number of visits per day of a link is shown.
  """
  @link = Link.find(params[:id]) 
  if @link.visits.present?
    @visit_counter_per_day = @link.visits.by_day
    @visit_counter_per_day.reject! { |day, count| count.zero? }
  else
    @visit_counter_per_day = {}
  end
end

private

  def redirect_regular_link
  """
  Redirect to the original url of the link
  """
    Visit.create_visit(@link, current_time, request.remote_ip)
    redirect_to @link.url, allow_other_host: true
  end

  def redirect_temporary_link
  """
  Redirect to the original url of the link if the expiration date is greater than the current date
  """
    if @link.expiration_date > current_time.to_date
      Visit.create_visit(@link, current_time, request.remote_ip)
      redirect_to @link.url, allow_other_host: true
    else
      not_found
    end
  end

  def redirect_ephemeral_link
  """
  Redirect to the original url of the link if the link has not been accessed before
  """
    if !@link.accessed?
      Link.link_disable
      Visit.create_visit(@link, current_time, request.remote_ip)
      redirect_to @link.url, allow_other_host: true
    else
      forbidden
    end
  end

  def current_time
    DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
  end 

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

  def authorize_user!
    unless current_user == @link.user
      forbidden
    end
  end

  # Only allow a list of trusted parameters through.
  def link_params
  """
  Permit the parameters of the link
  """
    params.require(:link).permit(:name, :url, :expiration_date, :link_type, :password, :link_type)
  end
end


