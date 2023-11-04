json.extract! kb_document, :id, :name, :pages_count, :document_file, :cover_image, :summary, :summary_embedding, :created_at, :updated_at
json.url kb_document_url(kb_document, format: :json)
json.document_file url_for(kb_document.document_file)
json.cover_image url_for(kb_document.cover_image)
