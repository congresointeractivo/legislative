
#Allow better errors in the server
BetterErrors::Middleware.allow_ip! ENV['TRUSTED_IP'] if ENV['TRUSTED_IP']

Legislative::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  config.action_controller.asset_host = ENV['root_url']

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  config.eager_load = false

  # Send congreso interactivo mails to Cuttlefish (see http://cuttlefish.io)
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address => "50.116.29.205",
    :port => 2525,
    :user_name => "congreso_interactivo_2",
    :password => "pnmTy0PpU0HA7EO6a6N8",
    :authentication => :plain
   }


end
