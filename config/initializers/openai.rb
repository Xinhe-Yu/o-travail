OpenAI.configure do |config|
  config.access_token = ENV.fetch("OPENROUTER_API_KEY")
end
