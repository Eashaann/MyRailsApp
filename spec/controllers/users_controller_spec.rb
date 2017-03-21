require 'rails_helper'

describe UsersController, :type => :controller do
  
  before do
    # @user = User.create!(email:"asd@123.com", password:"123456")
     @user = FactoryGirl.create(:user)
     #@user2 = User.create!(email:"xyz@123.com", password:"1234567")
     @user2 = FactoryGirl.create(:user, password:"1234567")
  end

  describe 'GET #show' do 
    context 'User is logged in' do
      before do
        sign_in @user
        request.env["HTTP_REFERER"] = "/login"
      end

      it 'loads correct user details' do
         get :show, id: @user.id
         expect(response).to be_success
         expect(response).to have_http_status(200)
         expect(assigns(:user)).to eq @user
      end

      it 'no access to other user pages' do
        get :show, id: @user2.id
        expect(response).to redirect_to('/login')
      end

      it 'redirect the user with a HTTP 302 status code' do
        get :show, id: @user2.id
        expect(response).to have_http_status(302)
      end
    end

    context 'No user is logged in' do

      it 'redirects to login' do
        get :show, id: @user.id
        expect(response).to redirect_to('/login')
      end
    end
  end
 
end