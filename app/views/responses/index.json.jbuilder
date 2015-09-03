if @issue
  json.issue do
    json.id @issue.id
    json.question @issue.question
    json.answers do
      json.array!(@answers)
    end
    json.answerType "select1"
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