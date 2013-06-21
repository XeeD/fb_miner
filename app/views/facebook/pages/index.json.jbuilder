json.array!(@facebook_pages) do |facebook_page|
  json.extract! facebook_page, :fb_id, :name, :url
  json.url facebook_page_url(facebook_page, format: :json)
end
