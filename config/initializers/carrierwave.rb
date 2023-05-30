unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory = ENV['DANSYARYU_BUCKET_NAME']
    config.fog_public = false
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['DANSYARYU_ACCESS_KEY'],
      aws_secret_access_key: ENV['DANSYARYU_SECRET_KEY'],
      region: ENV['DANSYARYU_REGION'],
      path_style: true
    }
  end
end