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
rails generate scaffold Kb::Document name:string num_pages:integer document_file:attachment cover_image:attachment summary:text summary_embedding:vector{1536} --skip-stylesheets-css
```

```ruby
module Kb
  class Document
    # Fields for Document: title, num_pages, summary, vectorized_summary, cover_image
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
