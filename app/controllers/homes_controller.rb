class HomesController < ApplicationController
	def top
		@tag_list = Tag.all
		@posts = Post.order("RANDOM()").limit(4)
	end

	def about
	end
end
