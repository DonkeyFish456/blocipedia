require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new( username:'Stan', email:'stancalderon@gmail.com', password: 'password', password_confirmation: 'password') }

  describe 'attributes' do
    it 'should have username and email attributes' do
      expect(user).to respond_to(:username, :email)
    end
  end

  describe 'invalid user' do
    let(:user_with_invalid_username) { User.new(name: 'Stan', email: 'stan@gmail.com', password: 'password', password_confirmation: 'password') }
    let(:user_with_invalid_email) { User.new(name: 'StanCalderon', email: 'stancalderon@gmail.com', password: 'password', password_confirmation: 'password')  }

    it 'should be an invalid user due to a duplicate username' do
      expect(user_with_invalid_username).to_not be_valid
    end
  end
end
