def webhose_search_response
  '{
    "posts":
    [
      {
        "uuid": "f96112178a860641a7fd6afb67b5f65ebf93dea3",
        "url": "http://test.com",
        "ord_in_thread": 0,
        "title": "title 1",
        "text": "text 1"
      },
      {
        "uuid": "f96112178a860641a7fd6afb67b5f65ebf93dea3",
        "url": "http://test.com",
        "ord_in_thread": 10,
        "title": "title 2",
        "text": "text 2"
      }
    ]
}'
end

def mock_webhose_search_response
  parsed_response = JSON.parse(webhose_search_response)
  (parsed_response['posts'] || []).map do |post|
    Services::Models::Webhose::Search.new(post)
  end
end