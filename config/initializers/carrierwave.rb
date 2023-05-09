unless Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: 'AKIAUU7HJMAZ666E2U5N',
        aws_secret_access_key: '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',
        region: 'ap-northeast-1'
      }
  
      config.fog_directory  = 'dansyaryu-storage'
      config.cache_storage = :fog
    end
  end