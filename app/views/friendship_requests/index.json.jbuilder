json.array!(@friendship_requests) do |friendship_request|
  json.extract! friendship_request, :id, :user_id, :friend_id
  json.url friendship_request_url(friendship_request, format: :json)
end
