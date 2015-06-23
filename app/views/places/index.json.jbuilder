json.array!(@places) do |place|
  json.extract! place, :id, :name, :url_name, :state, :json
  json.url place_url(place, format: :json)
end
