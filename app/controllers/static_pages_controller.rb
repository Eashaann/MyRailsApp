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

  def thank_you
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    # ActionMailer::Base.mail(:from => @email,
    #   :to => 'donaeasha25@gmail.com',
    #   :subject => "A new contact form message from #{@name}",
    #   :body => @message).deliver_now
    UserMailer.contact_form(@email, @name, @message).deliver_now
  end
end

