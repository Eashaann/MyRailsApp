require 'rails_helper'

describe Product do

	context "when the product has comments" do

		before do
		  	@product = Product.create!(name: "race bike", description: "test", price: 230)
		  	@user = User.create!(email: "race@ike" , password: "12351212")
		  	@product.comments.create!(rating: 1, user: @user, body: "Awful bike!")
		  	@product.comments.create!(rating: 3, user: @user, body: "good bike!")
		  	@product.comments.create!(rating: 5, user: @user, body: "nice bike!")
			end

			it "returns the average rating of all comments" do
				expect( @product.average_rating).to eq 3
			end

			it  "is not valid" do
				expect( Product.new(description: "Nice bike")).not_to be_valid
			end

	end

end