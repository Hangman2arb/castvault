require "active_support/core_ext/integer/time"

Rails.application.configure do

  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local = true

  config.server_timing = true

  config.assets.debug = true

  config.action_controller.perform_caching = true
  config.cache_store = :redis_cache_store, { url: ENV['REDIS_URL'] }

  config.active_storage.service = :local

  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  config.active_support.deprecation = :log

  config.active_support.disallowed_deprecation = :raise

  config.active_support.disallowed_deprecation_warnings = []

  config.active_record.migration_error = :page_load

  config.active_record.verbose_query_logs = true

  config.assets.quiet = true

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  Rails.application.routes.default_url_options[:host] = 'localhost:3000'

  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :letter_opener_web

  config.action_mailer.preview_path = "#{Rails.root}/test/mailers/previews"
end
