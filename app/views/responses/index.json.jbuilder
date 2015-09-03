if @issue
  json.issue do
    json.extract! @issue, :id, :question
  end
  
  json.responses do
    json.array!(@responses) do |response|
      json.extract! response, :id, :install_id, :issue_id, :answer, :timestamp, :lat, :lng
      json.url response_url(response, format: :json)
    end
  end
else
  json.array!(@responses) do |response|
      json.extract! response, :id, :install_id, :issue_id, :answer, :timestamp, :lat, :lng
      json.url response_url(response, format: :json)
    end
end