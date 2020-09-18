class PostTag < ApplicationRecord
  # アソシエーション
  belongs_to :tag
  belongs_to :post
end
