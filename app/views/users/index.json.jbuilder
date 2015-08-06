json.array!(@users) do |user|
  json.extract! user, :id, :install_id, :created_at
  json.url user_url(user, format: :json)
end
