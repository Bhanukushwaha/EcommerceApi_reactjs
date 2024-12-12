class Student < ApplicationRecord
  has_one_attached :image
	before_save :set_default_cauntry
	def set_default_cauntry
		puts "sfjsdjsdl"
	end
	def image_url
		if self.image.attached?
			"http://localhost:3000" + Rails.application.routes.url_helpers.rails_blob_url(self.image, only_path: true)
		else
			nil
		end
	end
end
