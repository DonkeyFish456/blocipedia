class CollaboratorsController < ApplicationController
  def index
  end

  def new
    @collaborator = Collaborator.new
  end

  def create
    @collaborator = Collaborator.new
    @collaborator.wiki_id = params['collaborator'][:wiki_id]
    @collaborator.user_id = params['collaborator'][:user_id]

    if Collaborator.exists?(user_id: @collaborator.user_id, wiki_id: @collaborator.wiki_id)
      flash[:alert] = 'This user is already a collaborator'
      redirect_to wiki_path(params['collaborator']['wiki_id'])
    else
      if @collaborator.save
        flash[:notice] = 'Collaborator added'
        redirect_to wiki_path(params['collaborator']['wiki_id'])
      else
        flash[:notice] = 'This is not a valid user'
        redirect_to wiki_path(params['collaborator']['wiki_id'])
      end
    end
  end
end