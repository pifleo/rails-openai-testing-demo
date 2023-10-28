# MyGPT Project Setup

How to build an AI chatbot with Ruby on Rails and ChatGPT: https://medium.com/@rubyroidlabs/how-to-build-an-ai-chatbot-with-ruby-on-rails-and-chatgpt-9a48f292c37c

## Setup

### Initialize Ruby on Rails project with PostgreSQL

**Check environment**

```bash
ruby --version # ruby 3.2.2
rails --version # Rails 7.1.1
```

**Initialize Rails project ([docs](https://guides.rubyonrails.org/getting_started.html))**

```bash
rails new my_gpt --database=postgresql --css=tailwind
cd my_gpt
```

**Setup VSCode dev container + project config files**

```bash
# cp .devcontainer .vscode .editorconfig .rubocop.yml config in project
# from our shared config repository https://github.com/tekncoach/vscode-ruby-dev-container
```

**Setup database**

The best way to install PostgreSQL on your MacOS is not to install it at all.
Instead, just run a docker container with a required PostgreSQL version. We will use [ankane/pgvector](https://hub.docker.com/r/ankane/pgvector/tags) image, therefore we will have [pgvector extension](https://github.com/pgvector/pgvector#docker) preinstalled.

```bash
# Command from the medium article, but we will use docker-compose instead to run everything inside a dev container
# docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres --name my_gpt_postgres ankane/pgvector
```

Edit `docker-compose.yml` db service image to use ankane/pgvector as we need vector search :
```yaml
  db:
    image: ankane/pgvector:latest
    restart: unless-stopped
```

Add this to `config/database.yml` to the `default` or `development` section:
```yaml
default: &default
  host: db
  username: postgres
  password: postgres

#... omitted
```

VSCode : `Reopen project in container` (From command palette)

Then initialize the database structure:
```bash
bundle install
rails db:create
rails db:migrate
```

**Run the app**
```bash
bin/dev
```

## Setup PGVector

We will use the gem [neighbor](https://github.com/ankane/neighbor) to work with PGVector. If you run PostgreSQL with Docker as described above, there is no need to install and build PGVector extension. So you can move on to this:

```bash
bundle add neighbor
rails generate neighbor:vector
rails db:migrate
```
