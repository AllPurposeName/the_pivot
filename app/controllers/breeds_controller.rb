class BreedsController < ApplicationController

  def index
    @breeds = Breed.all
  end

  def show
    @breed = Breed.find_by(name: params[:name])
    @garments = @breed.garments
  end

end
