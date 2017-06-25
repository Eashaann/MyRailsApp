require 'rails_helper'

describe ProductsController, :type => :controller do
  
  before do   
   @user = FactoryGirl.create(:user)
   @admin = FactoryGirl.create(:admin)
   @product = FactoryGirl.create(:product, name:'Lumala bike')
   @product1 = FactoryGirl.create(:product, name:'Mountain bike')     
  end

  describe 'GET #index' do
    context 'with search params' do
       before do
          get :index, params: {q:'oun'}
       end

      it 'return an array of products matching to search params' do        
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'loads matching products into @products' do
        expect(assigns(:products)).to match_array([@product1])
      end

      it 'renders the index template' do
        expect(response).to render_template('index')
      end
    end

    context 'without search params' do
       before do
          get :index
       end

      it 'responds successfully with an HTTP 200 status code' do        
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'loads all of the products into @products' do
        expect(assigns(:products)).to match_array([@product, @product1])
      end

      it 'renders the index template' do
        expect(response).to render_template('index')
      end
    end
  end
   
  describe 'GET #show' do
    
    before do       
        get :show, params: { id: @product.id }
    end

    it 'responds successfully with an HTTP 200 status code' do
        expect(response).to be_success
        expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end
    
  end

  describe 'GET #new' do
    context 'when a user not logged in' do      
      it 'responds with a HTTP 500 status code' do
        request.env["HTTP_REFERER"] = '/login'
        get :new
        expect(response).to have_http_status(302)
      end
    end

    context 'when a normal user logged in' do     
      it 'responds with a HTTP 500 status code' do
        sign_in @user
        request.env["HTTP_REFERER"] = '/login'
        get :new
        expect(response).to have_http_status(302)
      end
    end
    context 'when admin logged in' do
      before do
          sign_in @admin
          request.env["HTTP_REFERER"] = '/login'
          get :new
      end

      it 'responds successfully with an HTTP 200 status code' do 
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'renders the new template' do 
        expect(response).to render_template('new')
      end
    end
  end

   describe 'GET #edit' do
    context 'whan a user not logged in'do      
      it 'responds with a HTTP 500 status code' do
        request.env["HTTP_REFERER"] = '/login' 
        get :edit, params: { id: @product.id }
        expect(response).to have_http_status(302)
      end
    end

    context 'when a notmal user logged in'do   
      it 'responds with a HTTP 500 status code' do
        sign_in @user
        request.env["HTTP_REFERER"] = '/login'       
        get :edit, params: { id: @product.id }
        expect(response).to have_http_status(302)
      end
    end

    context 'when an admin logged in' do
      before do
        sign_in @admin
        request.env["HTTP_REFERER"] = '/login'       
        get :edit, params: { id: @product.id }
      end
      it 'responds successfully with an HTTP 200 status code' do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'renders the edit template' do
        expect(response).to render_template('edit')
      end
    end   
  end

  describe "POST #create" do
    before do
        sign_in @admin
        request.env["HTTP_REFERER"] = '/login'          
    end
    context "with valid parameters" do
      it "saves the new product in the database" do
        expect{
          post :create, params: {product: FactoryGirl.attributes_for(:product)}
          }.to change(Product, :count).by(1)
      end

      it "redirects to products#index" do
        post :create, params: {product: FactoryGirl.attributes_for(:product)}
        expect(response).to redirect_to('/products')
      end
    end

    context "with invalid parameters" do
      it "does not save the new product in the database" do
        expect{
          post :create, params: {product: FactoryGirl.attributes_for(:product, name: nil)}
          }.not_to change(Product, :count)
      end

      it "renders the new: template" do
        post :create, params: {product: FactoryGirl.attributes_for(:product, name: nil)}
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      before do
        sign_in @admin
        request.env["HTTP_REFERER"] = '/login' 
        patch :update, params: {
          id: @product.id, product: { name: 'Awesome bike', price: '100' }
        }
      end
      it "updates @product's attributes" do        
        @product.reload
        expect(@product.name).to eq("Awesome bike")
        expect(@product.price).to eq(100)
      end

      it "redirects to the updated product" do        
        expect(response).to redirect_to @product
      end
    end

    context "with invalid parameters" do
      before do
        sign_in @admin
        request.env["HTTP_REFERER"] = '/login' 
        patch :update, params: {id: @product.id , product: {name: nil}}
      end
      it "does not change the product's attributes" do        
        @product.reload
        expect(@product.name).to eq("Lumala bike")
      end

      it "renders the :edit template" do        
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before do
        sign_in @admin
        request.env["HTTP_REFERER"] = '/login'          
    end
    it "deletes the product" do
      expect{
        delete :destroy, params: {id: @product.id}
      }.to change(Product, :count).by(-1)
    end

    it "redirects to products#index" do
      delete :destroy, params: {id: @product.id}
      expect(response).to redirect_to('/products')
    end
  end 
end