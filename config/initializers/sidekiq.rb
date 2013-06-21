Sidekiq.configure_server do |config|
  config.redis = { namespace: 'fb_miner' }
end
