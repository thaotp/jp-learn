json.array!(@mimi_examples) do |mimi_example|
  json.extract! mimi_example, :id
  json.url mimi_example_url(mimi_example, format: :json)
end
