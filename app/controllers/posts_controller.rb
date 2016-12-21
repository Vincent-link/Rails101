class PostsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :destroy, :edit]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = "Post deleted"
    redirect_to account_posts_path
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)

    if @post.save
      redirect_to account_posts_path, notice: "Update Success"
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
