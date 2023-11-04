class TextExtractionJob < ApplicationJob
  queue_as :default

  def perform(document_id)
    document = Kb::Document.find(document_id)
    return unless document
    return unless document&.document_file&.attached?
    # return if document.summary.present?

    # Download a blob to a file on disk so an external program (e.g. a virus scanner or media transcoder) can operate on it.
    # https://edgeguides.rubyonrails.org/active_storage_overview.html#downloading-files
    document.document_file.open do |file|
      num_pages, text = extract_pdf_text_with_poppler(file)

      # page_count = TextExtractor.extract_text(file)
      # text = TextExtractor.extract_text(file) # Use your text extraction logic here
      document.update!(summary: text, num_pages: num_pages + 1)
    end
  end

  def extract_pdf_text_with_poppler(file)
    text = ''
    num_pages = 0

    poppler_document = Poppler::Document.new(file.path)
    poppler_document.map.with_index do |page, index|
      num_pages = index
      text << page.get_text
    end
    [num_pages, text]
  end
end

# https://edgeguides.rubyonrails.org/active_job_basics.html
