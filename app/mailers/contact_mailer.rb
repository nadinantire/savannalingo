class ContactMailer < ApplicationMailer
  default to: 'donat@savannalingo.com'

  def contact_email(name, email, message)
    @name = name
    @email = email
    @message = message

    mail(from: email, subject: 'New Contact Message')
  end
end
