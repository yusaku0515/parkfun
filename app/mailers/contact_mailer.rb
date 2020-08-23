class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.contact_mail.subject
  #
  # 送信機能
  def contact_mail(contact)
    @contact = contact
    mail(
      from: 'system@example.com',
      to: ENV['MAIL_ADDRESS'],
      subject: 'お問い合わせ通知'
    )
  end
end
