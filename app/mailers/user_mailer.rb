class UserMailer < ApplicationMailer
	default from: "noreply@dubaibikes.com"

  def contact_form(email, name, message)
    @message = message
      mail(:from => email,
          :to => 'donaeasha25@gmail.com',
          :subject => "A new contact form message from #{name}")
  end

  def send_new_user_message(user)
    @user = user
    mail(:from => 'noreply@dubaibikes.com',
    		:to => user.email,
    		:subject => "New User created please review and enable.")
  end

  def send_order_created_message(order)
    @order = order
    mail(:from => 'noreply@dubaibikes.com',
        :to => order.user.email,
        :subject => "Your Order ID: #{order.id} ")
  end
end
