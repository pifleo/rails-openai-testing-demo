

## Page Schema

To generate the scaffolding for the Kb::Page resource, run the following Bash command:

```bash
rails generate scaffold Kb::Page document:references page_number:integer preview_image:attachment
rails generate migration AddPagesCountToKb::Document pages_count:integer
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

## Snippet Schema

To generate the scaffolding for the Kb::Snippet resource, run the following Bash command:

```bash
rails generate scaffold Kb::Snippet page:references text:text embedding:vector{1536}
```

```ruby
module Kb
  class Snippet
    # Fields for Snippet: type (title, header, paragraph, sentence), text, vectorized_text
    belongs_to :page, class_name: 'Kb::Page'
  end
end
```
