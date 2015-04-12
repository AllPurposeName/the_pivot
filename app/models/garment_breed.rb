class GarmentBreed < ActiveRecord::Base
  after_create :set_garment_image

  belongs_to :garment
  belongs_to :breed

  def set_garment_image
    if !garment.image_path
      garment.update(image_path: breed.image_path)
    end
  end
end

ItemCategory = GarmentBreed
