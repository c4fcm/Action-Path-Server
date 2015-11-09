json.array!(@responses) do |response|
  json.extract! response, :install_id, :issue_id, :answer, :comment, :lat, :lng
  json.timestamp response.timestamp.to_time.to_i
  if response.photo_url.exists?
	json.photo_url asset_url(response.photo_url.url(:medium))
  else
    json.photo_url ""
  end
  json.url response_url(response, format: :json)
end
