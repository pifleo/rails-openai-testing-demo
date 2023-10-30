class Kb::Document < ApplicationRecord
  has_one_attached :file do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, 150]
  end

  after_create :set_filename

  private

  def set_filename
    return unless file.attached?

    update_column(:name, file.filename.to_s)
  end
end
