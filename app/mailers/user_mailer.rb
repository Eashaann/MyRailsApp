class UserMailer < ApplicationMailer
	default from: "irushaviraj@gmail.com"

  def contact_form(email, name, message)
  @message = message
    mail(:from => email,
        :to => 'donaeasha25@gmail.com',
        :subject => "A new contact form message from #{name}")
  end
end
