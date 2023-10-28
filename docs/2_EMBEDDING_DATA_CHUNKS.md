# Embeddings

## Data Chunks

To fit the limits or not spend all budget to 32K requests, let’s provide ChatGPT with the most relevant data. To do so, let’s split all data into small chunks and store it in the PostgreSQL database:

![Table with data chunks](images/1_luNBEWLOdWQV7lmb1RjZKw.webp)

Now, based on the user’s question, we need to find the most relevant chunk in our database. Here Embeddings API can help us. It gets a text and returns a vector (array of 1536 numbers).

![Schema embedding API](images/0_BPWjUbjIVVfYjEAB.png)

Thus, we generate a vector for each chunk via Embeddings API and save it to DB.

```ruby
response = openai_client.embeddings(
  parameters: {
    model: 'text-embedding-ada-002',
    input: 'Rubyroid Labs has been on the web and mobile...'
  }
)

response.dig('data', 0, 'embedding') # [0.0039921924, -0.01736092, -0.015491072, ...]
```

That’s how our database looks now:

![Database preview with chunks](images/1__LI0_qzYN1D4K_UoGVPdWw.webp)

**Code:**

```bash
rails g model Item page_name:string text:text embedding:vector{1536}
rails db:migrate
```

Migration:

```ruby
class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :page_name
      t.text :text
      t.vector :embedding, limit: 1536

      t.timestamps
    end
  end
end
```

Model:

```ruby
class Item < ApplicationRecord
  has_neighbors :embedding
end
```

Rake task (`lib/tasks/index_data.rake`):

```ruby
DATA = [
  ['React Native Development', 'Rubyroid Labs has been on the web and mobile...'],
  ['Dedicated developers', 'Rubyroid Labs can give you a team of dedicated d...'],
  ['Ruby on Rails development', 'Rubyroid Labs is a full-cycle Ruby on Rails...'],
  # ...
]

desc 'Fills database with data and calculate embeddings for each item.'
task index_data: :environment do
  openai_client = OpenAI::Client.new

  DATA.each do |item|
    page_name, text = item

    response = openai_client.embeddings(
      parameters: {
        model: 'text-embedding-ada-002',
        input: text
      }
    )

    embedding = response.dig('data', 0, 'embedding')

    Item.create!(page_name:, text:, embedding:)

    puts "Data for #{page_name} created!"
  end
end
```

Run rake task:

```bash
rake index_data
```

## Vector

What is a vector? Simply, a [vector](https://en.wikipedia.org/wiki/Vector_(mathematics_and_physics)) is a tuple, or in other words, an array of numbers. For example, `[2, 3]` . In two-dimensional space, it can refer to a dot on the scalar plane:

![Vector schema](images/0_s8KX-T17sk6cycnz.png)
[2d vector](https://en.wikipedia.org/wiki/Euclidean_vector) on the scalar plane

The same applies to three and more dimensional spaces:

![3d vector](images/0_dOk9yJIOrimYkKy_.png)

If we had 2d vectors, not 1536d vectors, we could display them on the scalar plane like this:

![2d vector schema](images/0_jA2ilMeIRqHzYc_i.png)

## How to find the most relevant chunks
So, the app receives the following question: “How long has RubyroidLabs been on the mobile software market?”. Let’s calculate its vector as well.

```ruby
response = openai_client.embeddings(
  parameters: {
    model: 'text-embedding-ada-002',
    input: 'How long has RubyroidLabs been on the mobile software market?'
  }
)

response.dig('data', 0, 'embedding') # [0.009017303, -0.016135506, 0.0013286859, ...]
```

And display it on the scalar plane:

![Display question vector](images/0_vUwvVU0HDoFTRV3V.png)

Now we can mathematically find the nearest vectors. No AI is needed for this task. That’s what we previously set up PGVector for.

```ruby
nearest_items = Item.nearest_neighbors(
  :embedding, question_embedding,
  distance: "euclidean"
)
context = nearest_items.first.text
```

And now, just put this context to the Chat API as we already did previously.

```ruby
message_content = <<~CONTENT
  Answer the question based on the context below, and
  if the question can't be answered based on the context,
  say \"I don't know\".

  Context:
  #{context}

  ---

  Question: #{question}
CONTENT

# a call to Chat API
```

Here it is 🎉
- "How long has RubyroidLabs been on the mobile software market?"
- "Does RubyroidLabs do mobile development?"

![localhost reply with embeddingd](images/0_prTcPwmtY8hUxwAh.png)

Our chat answers are based on all the information we provided. Moreover, it almost doesn’t spend additional money per question but provides a better answer. However, you have to pay once for calculating embeddings when initializing the database. For 300K tokens with Ada v2, it [costs](https://openai.com/pricing) just $0.03.

![Cost embedding model ADA02](images/0_kJBMMFMLSic54yF5.png)
