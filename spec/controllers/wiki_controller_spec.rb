require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:user) { User.new(username: 'test', email: 'test@test.com', password: 'password', password_confirmation: 'password', created_at: "2016-11-17 03:05:57", updated_at: "2016-11-17 03:17:11")}
  let(:wiki) { Wiki.create!(title: 'wiki title', body: 'wiki body', private: false, user_id: user.id) }

  context 'guest user' do
    describe 'GET show' do
      it 'returns http success' do
        get :show, id: wiki.id
        expect(response).to have_http_status(:success)
      end

      it 'renders the #show view' do
        get :show, id: wiki.id
        expect(response).to render_template :show
      end
    end
  end
end