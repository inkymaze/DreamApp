require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it 'validates username and password exists' do
      post :create, params: { user: {username: "", password: "" } }
      expect(response).to render_template(:new)
      expect(flash[:errors]).to be_present
    end

    it 'validates the length of the password' do
      post :create, params: { user: {username: "someuser", password: "short" } }
      expect(response).to render_template(:new)
      expect(flash[:errors]).to be_present
    end

    it 'successfully redirects page if valid credentials' do
      post :create, params: { user: {username: "someuser", password: "shosadart" } }
      expect(response).to redirect_to(users_url)
    end
  end
#


  describe "GET #show" do
    FactoryGirl.create(:user)

    it "renders show template successfully" do
      get :show, params: { id: 1 }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end

  end

end
