require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DinnerDash
  class Application < Rails::Application
config.active_record.raise_in_transactional_callbacks = true
config.active_job.queue_adapter = :sidekiq
config.action_mailer.delivery_method = :smtp

config.action_mailer.default_options = {from: 'noreply.handmeups@gmail.com'}
config.action_mailer.smtp_settings = {
  address:              'smtp.mandrillapp.com',
  port:                 '587',
  domain:               'handmeups.clothing',
  user_name:            ENV['mandrill_username'],
  password:             ENV['API_key'],
  authentication:       'plain',
  enable_starttls_auto: true
}

  end
end
