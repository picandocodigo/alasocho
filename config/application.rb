require File.expand_path('../boot', __FILE__)

require 'rails/all'

require 'haml'
require 'coffee_script'
require 'jquery-rails'
require 'backbone-rails'

require 'jquery-rails'
require "rails-i18n"

require 'hoptoad_notifier'

require 'postmark-rails'

if defined?(Bundler)
  Bundler.setup *Rails.groups(:assets => %w(development test))
end

module ALasOcho
  def self.config
    @config ||= begin
      config = YAML.load_file(Rails.root.join("config/settings.yml"))
      config.fetch(Rails.env.to_s, {}).with_indifferent_access
    end
  end

  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true

    config.action_mailer.delivery_method = :postmark
    config.action_mailer.postmark_settings = { api_key: "b494a82c-c77b-4f3c-a502-e8a0f5c33424" }
  end
end
