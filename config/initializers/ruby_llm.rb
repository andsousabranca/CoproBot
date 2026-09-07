RubyLLM.configure do |config|
  # Google Gemini (GitHub Models was retired). Key from aistudio.google.com.
  config.gemini_api_key = ENV["GEMINI_API_KEY"]
end