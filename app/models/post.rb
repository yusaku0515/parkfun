class Post < ApplicationRecord

  attachment :post_image

  # アソシエーション
  belongs_to :user

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags #throughオプションを使用することでpost_tag経由でtagsにアクセスできる

  scope :published, -> { where(published: true) }

  def save_posts(tags)
    #self.tags.plunk(:tag_name)->tagsテーブルのtag_nameカラムの一覧を取り出す #unless self.tags.nil? unless→もしも評価が偽(false)ならば〜〜する nil?→nilの場合のみtrueを返し、それ以外はfalseを返す
	current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
	old_tags = current_tags - tags #既存のタグの配列から配列を除外
	new_tags = tags - current_tags
	# destroy
	old_tags.each do |old_name| #post.tagsの配列から、Tag.find_byで検索して取得したtagを削除します。
		self.tags.delete Tags.find_by(tag_name:old_name)
	end
	# create
	new_tags.each do |new_name|
		post_tag = Tag.find_or_create_by(tag_name:new_name) #find_or_create_by オブジェクトが存在する場合は取得、なければ作成
		self.tags << post_tag #self.tags.push(post_tag)と一緒の意味
	end
  end

end
