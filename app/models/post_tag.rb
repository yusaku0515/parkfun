class PostTag < ApplicationRecord
	# アソシエーション
	belongs_to :tag
	belongs_to :post

	# バリデーション
	validates :tag_name, presence: true
end
