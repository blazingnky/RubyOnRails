json.array!(@members) do |member|
  json.extract! member, :id, :name, :email, :lock_version
  json.url member_url(member, format: :json)
end
