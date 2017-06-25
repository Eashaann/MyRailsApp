require 'rails_helper'

describe Comment do

	context "create comments without required values" do

			it  "is not valid" do
				expect( Comment.new(body: "Awesome bike!!!")).not_to be_valid
			end

	end

end