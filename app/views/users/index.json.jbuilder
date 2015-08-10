json.array!(@users) do |user|
  json.extract! user, :id, :username, :created_at
  json.url user_url(user, format: :json)
end
