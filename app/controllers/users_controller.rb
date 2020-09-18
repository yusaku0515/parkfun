class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:member_status] == "false" # 退会用の記述
      @user.user_status = false
      @user.update(user_params)
      reset_session # ログアウトする
      redirect_to root_path
      return # ここから下は実行されない
    else
      if @user.update(user_params) # 会員情報の編集
        redirect_to user_path(@user.id), notice: "変更内容を更新しました"
      else # エラーメッセージ表示用
        render 'edit'
        end
    end
  end

  def leave
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :user_status)
  end
end
