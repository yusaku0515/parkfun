class SearchesController < ApplicationController
  def search
  	if params[:keyword]
	    @keyword = params[:keyword]
	    @searched_posts = Post.search(params[:keyword])
	    render 'search'
	else
		render 'search'
	end
  end
end
