class Kb::Document < ApplicationRecord
  has_one_attached :document_file do |attachable|
    # attachable.variant :thumb, resize_to_limit: [150, 150]
    attachable.variant :cover_image, resize_to_limit: [200, 200]
    attachable.variant :preview, resize_to_limit: [420, 420]
  end

  after_create :set_filename

  private

  def set_filename
    return unless document_file.attached?

    update_column(:name, document_file.filename.to_s)
  end
end
