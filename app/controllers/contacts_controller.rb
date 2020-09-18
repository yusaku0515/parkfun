class ContactsController < ApplicationController
  def new
    @user = User.find_by(params[:id])
  	@contact = Contact.new
  end

  def create
  	@contact = Contact.new(contact_params)
  	if @contact.save
  		ContactMailer.contact_mail(@contact).deliver
  		redirect_to root_path, notice: "お問い合わせを受け付けました"
  	else
  		render :new, notice: "メールアドレスかお問い合わせ内容に空白があると送信できません"
  	end
  end

  private

  def contact_params
  	params.permit(:message, :email)
  end
end
