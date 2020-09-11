class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    if params[:tag_id] # タグの絞り込みで関連記事を表示する場合
      @tag_list = Tag.all.order(id: "DESC")
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.page(params[:page]).per(8)
    else # 全件表示の場合
      @tag_list = Tag.all
      @posts = Post.page(params[:page]).per(8)
    end
    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    # PV値測定
    impressionist(@post, "message...")
    @page_views = @post.impressionist_count(:filter => :ip_address)
    @post_tags = @post.tags
    @comments = @post.comments
    @comment = @post.comments.build
    @like = Like.new
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_name).join(",")
    if @post.user_id == current_user.id
      render 'edit'
    else
      redirect_to posts_path, notice: "現ユーザーが投稿したものでないので編集ページへアクセスできません"
    end
  end

  def create
    @post = Post.new(post_params)
    tag_list = params[:post][:tag_name].split(",")
    respond_to do |format|
      @post.user_id = current_user.id
      if @post.save
        @post.save_posts(tag_list)
        format.html { redirect_to @post, notice: "投稿しました" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(",")
    respond_to do |format|
      if @post.update(post_params)
        @post.save_posts(tag_list)
        format.html { redirect_to @post, notice: "投稿を編集しました" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :address, :post_image, :user_id, :tag_list)
  end
end
