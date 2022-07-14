class FlatsController < ApplicationController
  # before_action :set_flat, only: %i[show update destroy]
  def index
    @flats = Flat.all
    # The `geocoded` scope filters only flats with coordinates
    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    if @flat.save
      flash[:success] = "Flat successfully created"
      redirect_to flats_path
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end


  # private

  # def set_flat
  #   @flat = Flat.find(params[:id])
  # end

  def flat_params
    params.require(:flat).permit(:name, :address, :description, :price_per_night, :number_of_guests)
  end
end
