class StaticPagesController < ApplicationController
  def about
  end

  def contact
  end

  def home
  end

  def landing_page
    @featured_product = Product.first
    @products = Product.limit(3)
  end
end
