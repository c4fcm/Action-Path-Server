json.array!(@responses) do |response|
  json.extract! response, :id, :user_id, :issue_id, :answer, :timestamp
  json.url response_url(response, format: :json)
end
