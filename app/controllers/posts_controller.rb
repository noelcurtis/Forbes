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
    redirect_by_post_type
  end

  private
    def redirect_by_post_type
      if defined?(@place) and defined?(@neighborhood) 
        redirect_to neighborhood_place_path(@neighborhood, @place)
      elsif defined?(@neighborhood)
        redirect_to @neighborhood
      else
        redirect_to @post 
      end
    end

    def set_vars_based_on_params
      @neighborhood = Neighborhood.find(params[:neighborhood_id]) unless params[:neighborhood_id].nil?
      @place = Place.find(params[:place_id]) unless params[:place_id].nil?
      if defined?(@place) and defined?(@neighborhood)
        @submit_post_url = neighborhood_place_post_path(@neighborhood, @place, @post)
      elsif defined?(@neighborhood)
        @submit_post_url = neighborhood_post_path(@neighborhood, @post)
      else
        @submit_post_url = post_path(@post)
      end
    end
end
