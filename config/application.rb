require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Slidegate
  class Application < Rails::Application
    config.time_zone = 'Tokyo'

    config.autoload_paths += ['lib']

    config.generators do |g|
      g.helper false
      g.javascripts false
      g.stylesheets false
    end
  end
end
