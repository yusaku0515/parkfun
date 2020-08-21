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
  def send_when_admin_reply(user, contact) #メソッドに対して引数を設定
    @user = user #ユーザー情報を取得
    @answer = contact.reply_text #返信内容
    mail(
      from: 'system@example.com',
      to: ENV['MAIL_ADDRESS'],
      subject: 'お問い合わせ通知'
    )
  end
end
