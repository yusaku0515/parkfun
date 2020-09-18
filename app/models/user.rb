class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    # アソシエーション
    has_many :posts, dependent: :destroy

    has_many :likes, dependent: :destroy
    has_many :liked_posts, through: :likes, source: :post

    # Notificationモデルのforeign_key: "visiter_id" で、visiter_idを参考に、active_notificationsモデルへアクセスする
    has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
    has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

    def already_liked?(post) # 既にいいねしているか？
        likes.exists?(post_id: post.id)
    end

    attachment :profile_image

    # バリデーション
    # パスワードが確認用と一致している事
    validates :encrypted_password, confirmation: true, length: { minimum: 6 }
    # 名前は空白ではいけない
    validates :name, presence: true
    # メールアドレスは空白ではいけない
    validates :email, presence: true
    # メール、存在性、フォーマット、一意性の検証
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
    validates :email, { format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false } }

end
