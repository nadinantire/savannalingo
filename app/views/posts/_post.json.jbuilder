json.extract! post, :id, :title, :body, :status, :slug, :published_at, :user_id, :created_at, :updated_at
json.url post_url(post, format: :json)
