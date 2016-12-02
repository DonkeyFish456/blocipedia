class Wiki < ApplicationRecord
  belongs_to :user

  def self.private?
    where(private: false)
  end
end
