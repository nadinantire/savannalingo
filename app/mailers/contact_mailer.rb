class ContactMailer < ApplicationMailer
  default to: 'donat@savannalingo.com'

  def contact_email(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(
      from: "donat@savannalingo.com",
      reply_to: email,
      subject: "New Contact Message"
    )

  end
end
