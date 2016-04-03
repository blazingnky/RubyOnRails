json.array!(@reviews) do |review|
  json.extract! review, :id, :book_id, :user_id, :body
  json.url review_url(review, format: :json)
end
