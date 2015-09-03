if @issue
  json.issue do
    json.id @issue.id
    json.question @issue.question
    if @issue.answer1.present?
      json.answer1 @issue.answer1
    end
    if @issue.answer2.present?
      json.answer2 @issue.answer2
    end
    if @issue.answer3.present?
      json.answer3 @issue.answer3
    end
     if @issue.answer4.present?
      json.answer4 @issue.answer4
    end
     if @issue.answer5.present?
      json.answer5 @issue.answer5
    end
     if @issue.answer6.present?
      json.answer6 @issue.answer6
    end
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