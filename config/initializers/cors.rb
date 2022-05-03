# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  Rails.application.config.allowed_cors_origins.each do |origin_item|
    allow do
      origins origin_item
      resource "/api/v1/login", :headers => :any, :methods => [:post]
      resource "/api/v1/tokens", :headers => :any, :methods => [:get]
      resource "/api/v1/menu", :headers => :any, :methods => [:post]
      resource "/api/v1/users", :headers => :any, :methods => [:post, :get, :patch]
      resource "/api/v1/users/*", :headers => :any, :methods => [:get]
      resource "/api/v1/products", :headers => :any, :methods => [:post, :get, :patch]
      resource "/api/v1/products/categories", :headers => :any, :methods => [:get]
      resource "/api/v1/people", :headers => :any, :methods => [:get, :post]
    end
  end
end
