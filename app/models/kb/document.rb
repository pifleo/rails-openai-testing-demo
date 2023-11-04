module Kb
  class Document < ApplicationRecord
    has_one_attached :document_file do |attachable|
      # attachable.variant :thumb, resize_to_limit: [150, 150]
      attachable.variant :cover_image, resize_to_limit: [200, 200], preprocessed: true
      attachable.variant :preview, resize_to_limit: [420, 420], preprocessed: true
    end

    # Fields for Document: title, summary, vectorized_summary, cover_image
    has_many :pages, class_name: 'Kb::Page', foreign_key: :kb_document_id, dependent: :destroy

    after_create :set_filename

    private

    def set_filename
      return unless document_file.attached?

      update_column(:name, document_file.filename.to_s)
    end
  end
end
