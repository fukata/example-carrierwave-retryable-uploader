class RetryableStorageFog < CarrierWave::Storage::Fog
  def store!(file)
    retryable(__method__) { super }
  end

  def cache!(new_file)
    retryable(__method__) { super }
  end

  def retrieve_from_cache!(identifier)
    retryable(__method__) { super }
  end

  def retrieve!(identifier)
    retryable(__method__) { super }
  end

  private
  def retryable(method_name)
    retryable_options = {
      tries: 5,
      sleep: lambda{|retries|
        retries += 1
        sleep_seconds = 2**retries
        Rails.logger.warn("[RetryableStorageFog##{method_name}] sleep=#{sleep_seconds}, retries=#{retries}")
        sleep_seconds
      },
      on: [StandardError],
    }
    Retryable.retryable(retryable_options) do |retries, e|
      if retries > 0
        Rails.logger.warn("[RetryableStorageFog##{method_name}] retries=#{retries}, e=#{e}")
      end
      yield
    end
  end
end
