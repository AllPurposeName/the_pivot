class GarmentCategory < ActiveRecord::Base
  after_create :set_garment_image

  belongs_to :garment
  belongs_to :category

  def set_garment_image
    if !garment.image_path
      garment.update(image_path: category.image_path)
    end
  end
end

ItemCategory = GarmentCategory
