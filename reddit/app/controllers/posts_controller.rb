class PostsController < ApplicationController
  before_action :ensure_logged_in 

  def new 
    @post = Post.new 

    render :new 
  end

  def create 
    @post = Post.new(post_params)
    @post.author_id = current_user.id #NEED TO CHECK
    if @post.save 
      redirect_to subs_url
    else
      flash[:errors] = @post.errors.full_messages 
      render :new 
    end
  end

  def show 
    @post = Post.find(params[:id])

    render :show 
  end

  def edit 
    @post = Post.find(params[:id])

    render :edit 
  end
  
  def update
    @post = current_user.posts.find_by(id: params[:id])
    if @post.update(post_params)
      redirect_to sub_url(@post.sub_id)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy 
    @post = current_user.posts.find_by(id: params[:id])
    @post.sub_id = @post.sub.id
    redirect_to sub_url(@post.sub_id) if @post && @post.destroy
  end

  private 
  def post_params 
    params.require(:post).permit(:title, :url, :content, sub_ids: [] )
  end
end