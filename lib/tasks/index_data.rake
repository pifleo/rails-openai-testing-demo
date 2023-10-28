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
