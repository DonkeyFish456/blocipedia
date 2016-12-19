class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  after_action :verify_authorized, only: [:destroy, :show]

  def index
    @wikis = ActiveRecord::Base.connection.execute(<<-SQL)
        SELECT wikis.id, wikis.title, wikis.body, wiki_users.username AS 'wiki_owner',
        COUNT(collab_users.username) AS 'collaborator_count'
        FROM wikis LEFT JOIN collaborators ON (wikis.id = collaborators.wiki_id)
        LEFT JOIN users collab_users ON (collaborators.user_id = collab_users.id)
        LEFT JOIN users wiki_users ON (wikis.user_id = wiki_users.id)
        WHERE wikis.private IN ('f', 0, 'false')
        OR collab_users.id = #{current_user.id}
        OR '#{current_user.role}' IN ('admin', 'premium')
        GROUP BY wikis.id, wikis.title, wikis.body, wiki_users.username
    SQL
  end

  def show
    @wiki = Wiki.find(params[:id])
    @collaborators = Collaborator.where(wiki_id: @wiki.id)
    @collaborator = Collaborator.new
    authorize @wiki
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
      if Collaborator.exists?(user_id: current_user.id, wiki_id: @wiki.id)
        flash[:notice] = 'Wiki was saved'
        redirect_to @wiki
      else
        @collaborator = Collaborator.create!(wiki_id: @wiki.id, user_id: current_user.id)
        flash[:notice] = 'Wiki was saved'
        redirect_to @wiki
      end
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
      if Collaborator.exists?(user_id: current_user.id, wiki_id: @wiki.id)
        flash[:notice] = 'Wiki was updated'
        redirect_to @wiki
      else
        @collaborator = Collaborator.create!(wiki_id: @wiki.id, user_id: current_user.id)
        flash[:notice] = 'Wiki was updated'
        redirect_to @wiki
      end
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
