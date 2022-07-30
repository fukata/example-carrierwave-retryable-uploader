CarrierWave.configure do |config|
  config.cache_storage = :fog

  config.asset_host = "http://127.0.0.1:9000/images"
  config.fog_directory = "images"
  config.fog_public = true
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }

  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['AWS_REGION'],
    endpoint: ENV['S3_ENDPOINT'],
    path_style: true
  }
end
