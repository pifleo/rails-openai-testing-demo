# How to build an AI chatbot with Ruby on Rails and ChatGPT

How to build an AI that can answer questions about your website.

This tutorial walks through a simple example of crawling a website (in this example, the Rubyroidlabs website), turning the crawled pages into embeddings using the Embeddings API, and then creating a basic search functionality that allows a user to ask questions about the embedded information. This is intended to be a starting point for more sophisticated applications that make use of custom knowledge bases.

Inspired from this blog post: https://medium.com/@rubyroidlabs/how-to-build-an-ai-chatbot-with-ruby-on-rails-and-chatgpt-9a48f292c37c

# Table of Contents

- [Introduction](docs/README.md)
- [Setup](docs/0_GETTING_STARTED.md)
    - Initialize Ruby on Rails project with PostgreSQL
    - Setup PGVector
    - Setup OpenAI
    - Build a simple chat with Hotwired

- [Prototype](docs/1_PROTOTYPE_CHAT_API.md)
    - Chat API
    - Deal-breaker

- [Embeddings](docs/2_EMBEDDING_DATA_CHUNKS.md)
    - Data Chunks
    - Vector
    - How to find the most relevant chunks

- [Summary](docs/3_SUMMARY.md)
