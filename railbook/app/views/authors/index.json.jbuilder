json.array!(@authors) do |author|
  json.extract! author, :id, :user_id, :name, :birth, :address, :ctype, :photo
  json.url author_url(author, format: :json)
end
