class SearchesController < ApplicationController
  def search
  	if params[:keyword]
	    @keyword = params[:keyword]
	    @searched_posts = Post.search(params[:keyword])
	else
		render 'search'
	end
  end
end
