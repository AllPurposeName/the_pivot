class Admin::InventoryController < ApplicationController
  before_action :set_garments, :set_breeds
  def index
    authorize! :edit, Breed
  end

  private

  def set_garments
    @garments = Garment.all
  end

  def set_breeds
    @breeds = Breed.all
  end

end
