FactoryGirl.define do
	sequence(:name) { |n| "product#{n}" }
	sequence(:description) { |n| "description#{n}" }

  factory :product do
  	name 
    description
  	price 100  	
	end
end
