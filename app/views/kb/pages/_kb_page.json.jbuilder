json.extract! kb_page, :id, :document_id, :page_index, :preview_image, :content, :created_at, :updated_at
json.url kb_page_url(kb_page, format: :json)
json.preview_image url_for(kb_page.preview_image)
