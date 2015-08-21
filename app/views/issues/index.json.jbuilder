json.array!(@issues) do |issue|
  json.extract! issue, :id, :id, :summary, :status, :description, :address, :scf_image_url, :lat, :lng, :created_at, :updated_at, :place_id, :geofence_radius, :question, :answer1, :answer2, :answer3, :answer4, :answer5, :answer6
  json.url issue_url(issue, format: :json)
  if issue.custom_image.exists?
	json.custom_image_url asset_url(issue.custom_image.url(:thumb))
  else
    json.custom_image_url ""
  end
end
