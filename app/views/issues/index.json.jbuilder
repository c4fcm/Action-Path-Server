json.array!(@issues) do |issue|
  json.extract! issue, :id, :id, :summary, :status, :description, :address, :image_full
  json.url issue_url(issue, format: :json)
end
