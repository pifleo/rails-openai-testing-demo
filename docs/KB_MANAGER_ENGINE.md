# Knowledge Base Manager • Engine

## Setup

Add a Home index page

```bash
rails g controller home index
```

Enable ActiveStorage

https://guides.rubyonrails.org/active_storage_overview.html

```bash
rails active_storage:install
rails db:migrate
bundle add image_processing
```

# KB Manager

## Document Schema

To generate the scaffolding for the Kb::Document resource, run the following Bash command:
```bash
rails generate scaffold Kb::Document name:string document_file:attachment cover_image:attachment summary:text summary_embedding:vector{1536}
```

```ruby
module Kb
  class Document
    # Fields for Document: title, summary, vectorized_summary, cover_image
    has_many :pages, class_name: 'Kb::Page'
    has_many :snippets, through: :pages, class_name: 'Kb::Snippet'
  end
end
```

```bash
bundle add poppler
bundle add pdf-reader
bundle add docx
bin/rails generate job TextExtraction
```

## Page Schema

To generate the scaffolding for the Kb::Page resource, run the following Bash command:

```bash
rails generate scaffold Kb::Page kb_document:references page_index:integer preview_image:attachment content:text
rails generate migration AddPagesCountToKbDocument pages_count:integer
```

```ruby
module Kb
  class Page
    # Fields for Page: page_number, vectorized_text, preview_image
    belongs_to :document, class_name: 'Kb::Document', counter_cache: true
    has_many :snippets, class_name: 'Kb::Snippet'
  end
end
```
