class ContactsController < ApplicationController
  def new
  end

  def create
    name = params[:name]
    email = params[:email]
    message = params[:message]

    if name.present? && email.present? && message.present?
      ContactMailer.contact_email(name, email, message).deliver_now
      flash[:notice] = "Your message has been sent!"
    else
      flash[:alert] = "All fields are required."
    end

    redirect_to new_contact_path
  end
end
