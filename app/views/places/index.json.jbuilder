json.array!(@places) do |place|
  json.extract! place, :id, :name, :url_name, :state, :issues_fetched_at
  json.url place_url(place, format: :json)
end
