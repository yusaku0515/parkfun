class Like < ApplicationRecord
	belongs_to :post
	belongs_to :user
	validates_uniqueness_of :post_id, scope: :user_id

	def create
		like = cureent_user.likes.new(post_id: @post.id)
		like.save
		@post = Post.find(params[:post_id])
		@post.create_notification_by(current_user)
		respond_to do |foemat|
			format.html {redirect_to request.referrer}
			format.js
		end
	end
end
