class WikiPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def destroy?
    @user.admin? || @user == @wiki.user
  end
end