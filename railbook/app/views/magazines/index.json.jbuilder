json.array!(@magazines) do |magazine|
  json.extract! magazine, :id, :isbn, :title, :price, :publish, :published, :cd
  json.url magazine_url(magazine, format: :json)
end
