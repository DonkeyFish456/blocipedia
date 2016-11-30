class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  after_action :verify_authorized, only: [:destroy]

  def index
    if user_signed_in? && (current_user.admin? || current_user.premium?)
      @wikis = Wiki.all
    else
      @wikis = Wiki.private?
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user_id = current_user.id

    if @wiki.save
      flash[:notice] = 'Wiki was saved'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error saving the wiki. Please try again.'
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

    if @wiki.save
      flash[:notice] = 'Wiki was updated'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error updating the wiki. Please try again.'
      render :show
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully"
      redirect_to wikis_path
    else
      flash.now[:alert] = 'There was an error was deleting the wiki.'
      render :show
    end
  end
end
