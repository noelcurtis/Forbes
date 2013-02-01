class PlacesController < ApplicationController
  def index
    @neighborhood = Neighborhood.find(params[:neighborhood_id])
    @places = @neighborhood.places
    set_categories

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places }
    end
  end

  def show
    @place = Place.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end

  def new
    @neighborhood = Neighborhood.find(params[:neighborhood_id])
    @place = Place.new
    set_categories

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @place }
    end
  end

  def edit
    @place = Place.find(params[:id])
  end

  def create
    @neighborhood = Neighborhood.find(params[:neighborhood_id])
    @place = Place.new(params[:place])

    if @place.save
      photo = Photo.new(image: params[:image], user_id: current_user.id, neighborhood_id: @neighborhood.id, place_id: @place.id)
      photo.save
      redirect_to neighborhood_place_path(@neighborhood, @place)
    else
      redirect_to new_neighborhood_place_path(@neighborhood)
    end
  end

  def update
    @place = Place.find(params[:id])

    respond_to do |format|
      if @place.update_attributes(params[:place])
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy

    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end

  private

  def set_categories
    @categories = [ ['Restaurant', 'Restaurant'], ['Park', 'Park'], ['School', 'School'], ['Bar', 'Bar'] ]
  end
end
