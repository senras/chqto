class LinksController < ApplicationController

    def index
        @links = Link.all
    end

    #GET form to create a new link
    def new
        @link = Link.new
    end
    
    #POST create a new link
    def create
        @link = Link.new(link_params)
        if @link.save
            redirect_to @link
        else
            render :new
        end
    end

    #GET show a link
    def show
        @link = Link.find_by(slug: params[:slug])
        if @link
            redirect_to @link.name
        else
            render :not_found, status: :not_found
        end
    end

    #GET form to edit a link
    def edit
        @link = Link.find(params[:id])
    end

    #PUT update a link
    def update
        @link = Link.find(params[:id])
        if @link.update(link_params)
            redirect_to @link
        else
            render :edit
        end
    end

    #DELETE destroy a link
    def destroy
        @link = Link.find(params[:id])
        @link.destroy
        redirect_to links_path
    end
end