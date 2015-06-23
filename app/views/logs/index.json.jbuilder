json.array!(@logs) do |log|
  json.extract! log, :id, :user_id, :issue_id, :action, :timestamp, :lat, :lng, :install_id
  json.url log_url(log, format: :json)
end
