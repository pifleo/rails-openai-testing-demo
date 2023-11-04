require 'pdf/reader'
require 'docx'

class TextExtractor
  def self.extract_text(file)
    return unless file&.attached?

    case file.content_type
    when 'application/pdf'
      extract_pdf_text(file)
    when 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' # docx
      extract_docx_text(file)
    when 'text/plain'
      extract_txt_text(file)
    else
      raise ArgumentError, 'Unsupported file format'
    end
  end

  def self.extract_pdf_text(file)
    text = ''
      PDF::Reader.open(file.path) do |reader|
        reader.pages.each do |page|
          text << page.text
        end
      end
    text
  end

  reader = nil
b.open do |io|
  reader = PDF::Reader.new(io)
  puts reader.pdf_version
  puts reader.info
  puts reader.metadata
  puts reader.page_count
  puts reader.raw_text
end

b.open do |file|
  PDF::Reader.open(b)
  # ...
end

  def self.extract_docx_text(file)
    doc = Docx::Document.open(file.path)
    text = ''
    doc.paragraphs.each do |paragraph|
      text << paragraph.text
    end
    text
  end

  def self.extract_txt_text(file)
    File.read(file.path)
  end
end

# https://github.com/rails/marcel/blob/main/lib/marcel/tables.rb
