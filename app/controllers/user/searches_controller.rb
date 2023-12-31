class User::SearchesController < ApplicationController

	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content, @method)
		elsif @model == 'post'
			@records = Post.search_for(@content, @method)
		elsif @model == 'tag'
			@records = Tag.search_posts_for(@content, @method)
		end
		@records = Kaminari.paginate_array(@records).page(params[:page]).per(12)
	end
end
