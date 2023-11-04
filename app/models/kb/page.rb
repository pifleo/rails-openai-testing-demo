module Kb
  class Page < ApplicationRecord
    # Fields for Page: page_number, vectorized_text, preview_image
    belongs_to :document, class_name: 'Kb::Document', foreign_key: :kb_document_id, counter_cache: true
    # has_one_attached :preview_image

    validates :page_index, uniqueness: { scope: :kb_document_id }
  end
end
