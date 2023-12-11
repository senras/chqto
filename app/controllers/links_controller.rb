class LinksController < ApplicationController
  before_action :set_link, only: %i[ show edit update destroy ]

  # GET /links
  def index
    @links = current_user.links.paginate(page: params[:page], per_page: 5)
  end

  # GET /links/1
  def show
    @link = Link.find(params[:id])
    @short = redirect_original_url_url(@link.slug) 
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # POST /links
  def create
    @link = current_user.links.build(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to link_url(@link), notice: "Link was successfully created." }
        # format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to link_url(@link), notice: "Link was successfully updated." }
        # format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  def destroy
    @link.destroy!
    respond_to do |format|
      format.html { redirect_to links_url, notice: "Link was successfully destroyed." }
    end
  end


def redirect_original_url
  @link = Link.find_by(slug: params[:slug])
  if @link.present?
    case @link.link_category
    when 'private'
      render 'send_to_url_with_password'
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

def authenticate_private_link
  @link = Link.find_by(slug: params[:slug])

  if @link.present? && @link.authenticate(params[:password])
    LinkAccess.create_visit(@link, current_time, request.remote_ip)
    redirect_to @link.url, allow_other_host: true
  else
    flash[:alert] = 'Invalid password'
    render 'send_to_url_with_password'
  end
end

private

  def redirect_regular_link
    LinkAccess.create_access(@link, current_time, request.remote_ip)
    redirect_to @link.url, allow_other_host: true
  end

  def redirect_temporary_link
    if @link.expiration_date > current_time
      LinkAccess.create_access(@link, current_time, request.remote_ip)
      redirect_to @link.url, allow_other_host: true
    else
      not_found
    end
  end

  def redirect_ephemeral_link
    if !@link.single_use?
      Link.link_disable
      LinkAccess.create_access(@link, current_time, request.remote_ip)
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

  # Only allow a list of trusted parameters through.
  def link_params
    params.require(:link).permit(:name, :url, :expiration_date, :link_type, :password, :link_type)
  end
end


