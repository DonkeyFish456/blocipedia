class WikiPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?
    @wiki.private == false || @user.admin? || @user.premium? || @user == @wiki.user || Collaborator.exists?(user_id: @user.id, wiki_id: @wiki.id)
  end

  def destroy?
    @user.admin? || @user == @wiki.user
  end
end
