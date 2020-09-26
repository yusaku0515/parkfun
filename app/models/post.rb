class Post < ApplicationRecord
    attachment :post_image

    # PV値測定
    is_impressionable

    # ページネーション（何個ずつ表示させるか）
    paginates_per 8

    # geocoderを使用する為の記述 addressに住所を登録した時に緯度・経度を自動で値を入力される
    geocoded_by :address
    # 住所変更時に緯度経度も変更する
    after_validation :geocode, if: :address_changed?

    # アソシエーション
    belongs_to :user

    has_many :post_tags, dependent: :destroy
    has_many :tags, through: :post_tags # throughオプションを使用することでpost_tag経由でtagsにアクセスできる

    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user

    has_many :comments, dependent: :destroy

    has_many :notifications, dependent: :destroy

    # バリデーション
    validates :title, presence: true
    validates :body, presence: true

    # 検索関係
    def self.search(keyword)
        where(['title LIKE ? OR body LIKE ?', "%#{keyword}%", "%#{keyword}%"])
    end

    # タグ機能に必要なメソット
    def save_posts(tags)
        # self.tags.plunk(:tag_name)->tagsテーブルのtag_nameカラムの一覧を取り出す #unless self.tags.nil? unless→もしも評価が偽(false)ならば〜〜する nil?→nilの場合のみtrueを返し、それ以外はfalseを返す
        current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
        old_tags = current_tags - tags # 既存のタグの配列から配列を除外
        new_tags = tags - current_tags
        # destroy
        old_tags.each do |old_name| # post.tagsの配列から、Tag.find_byで検索して取得したtagを削除します。
            self.tags.delete Tags.find_by(tag_name: old_name)
        end
        # create
        new_tags.each do |new_name|
            post_tag = Tag.find_or_create_by(tag_name: new_name) # find_or_create_by オブジェクトが存在する場合は取得、なければ作成
            self.tags << post_tag # self.tags.push(post_tag)と一緒の意味
        end
    end

    # 通知機能
    def create_notification_by(current_user)
        notification = current_user.active_notifications.new(
            post_id: id,
            visited_id: user_id,
            action: "like"
            )
        notification.save if notification.valid?
    end

    def create_notification_comment!(current_user, comment_id)
        temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
        temp_ids.each do |temp_id|
            save_notification_comment!(current_user, comment_id, temp_id['user_id'])
        end
        save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
    end

    def save_notification_comment!(current_user, comment_id, visited_id)
        notification = current_user.active_notifications.new(
            post_id: id,
            comment_id: comment_id,
            visited_id: visited_id,
            action: 'comment'
            )
        if notification.visiter_id == notification.visited_id #自分の投稿にいいねしても通知をしない
            notification.checked = true
        end
        notification.save if notification.valid?
    end
end
