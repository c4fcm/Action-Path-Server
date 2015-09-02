json.array!(@responses) do |response|
  json.extract! response, :id, :issue_id, :answer, :timestamp, :lat, :lng
  json.url response_url(response, format: :json)
end
