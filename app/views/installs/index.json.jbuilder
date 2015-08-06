json.array!(@installs) do |install|
  json.extract! install, :id, :id, :created_at
  json.url install_url(install, format: :json)
end
