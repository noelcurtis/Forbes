class PostsController < ApplicationController
   
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    set_vars_based_on_params
  end

  def edit
    @post = Post.find(params[:id])
    set_vars_based_on_params
  end

  def create
    @post = Post.new(params[:post])
    set_vars_based_on_params
    if @post.save 
      redirect_by_post_type
    end
  end

  def update
    @post = Post.find(params[:id])
    set_vars_based_on_params

    if @post.update_attributes(params[:post])
      redirect_by_post_type
    else
      defined?(@neighborhood) ? redirect_to(edit_neighborhood_post_path(@neighborhood, @post)) : render(action: "edit")
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    set_vars_based_on_params

    defined?(@neighborhood) ? redirect_to(@neighborhood) : redirect_to(current_user)
  end

  private
    def redirect_by_post_type
      defined?(@neighborhood) ? redirect_to(@neighborhood) : redirect_to(@post)
    end

    def set_vars_based_on_params
      @neighborhood = Neighborhood.find(params[:neighborhood_id]) unless params[:neighborhood_id].nil?
    end
end
