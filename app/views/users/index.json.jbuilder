json.array!(@users) do |user|
  json.extract! user, :id, :email, :sign_in_count, :last_sign_in_at
  json.url user_url(user, format: :json)
end
