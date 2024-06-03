# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:3001' # Update this with the URL of your React frontend
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options]
  end
end
