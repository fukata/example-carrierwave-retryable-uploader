class ImageUploader < CarrierWave::Uploader::Base
  storage RetryableStorageFog
  cache_storage RetryableStorageFog
end
