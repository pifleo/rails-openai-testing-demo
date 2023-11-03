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
