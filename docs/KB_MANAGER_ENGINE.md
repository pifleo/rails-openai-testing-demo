# Knowledge Base Manager • Engine

## Setup

https://guides.rubyonrails.org/active_storage_overview.html

```
# rails g scaffold Post title:string content:text
rails g scaffold ObjectStore name content:text
rails active_storage:install
rails db:migrate
```

```rails
rails g controller home index
rails g scaffold Kb::Document name content:text file:attachment
```
