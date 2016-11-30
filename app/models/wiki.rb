class Wiki < ApplicationRecord
  belongs_to :user

  # scope :private, -> { where(private: false ).or(private: nil)  }

  def self.private?
    where(private: false)
  end

end
