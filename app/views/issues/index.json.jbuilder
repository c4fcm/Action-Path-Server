json.array!(@issues) do |issue|
  json.extract! issue, :id, :id, :summary, :status, :description, :address, :image_full, :lat, :lng, :created_at, :updated_at, :place_id
  json.url issue_url(issue, format: :json)
end
