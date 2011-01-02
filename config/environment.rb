# Load the rails application
require File.expand_path('../application', __FILE__)

FlickRawOptions = {
  "api_key" => "057c502f9255c842b9edb266559858df",
  "shared_secret" => "6549f2f09d298c47",
  "auth_token" => "72157625587213643-c8c514e77dd1ac6e",
}
# Initialize the rails application
Blog::Application.initialize!
