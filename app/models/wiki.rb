class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  # scope :private, -> { where(private: false ).or(private: nil)  }

  def self.private?
    where(private: false)
  end

  def self.able_to_view_wiki?
    self.private? || @user.admin? || @user == self.user || Collaborator.exists?(user_id: @user.id, wiki_id: self.id)
  end
end
