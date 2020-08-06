class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーション

  # パスワードが確認用と一致している事
  validates :encrypted_password, confirmation: true, length: { minimum: 6 }
  #名前は空白ではいけない
  validates :name, presence: true
  #メールアドレスは空白ではいけない
  validates :email, presence: true
  # メール、存在性、フォーマット、一意性の検証
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, { format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false } }
end
