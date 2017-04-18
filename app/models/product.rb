class Product < ApplicationRecord
  has_many :comments
  has_many :orders

  def self.search(search_term)
  	if Rails.env.production?
  		Product.where("name ilike ?", "%#{search_term}%")
  	else
  		Product.where("name LIKE ?", "%#{search_term}%")
  	end  	
	end
  
  def highest_rating_comment
  	comments.rating_desc.first
	end

	def lowest_rating_comment
  	comments.rating_asc.first
	end

  def average_rating
    comments.average(:rating).to_f
  end

# models/product_view.rb

def views
  $redis.get("product:#{id}") # this is equivalent to 'GET product:1'
end

def viewed!
  $redis.incr("product:#{id}") # this is equivalent to 'INC product:1'
end



#validations
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :price, numericality: { only_integer: true } 
end

