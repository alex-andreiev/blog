# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    config.load_defaults 5.2
    config.autoload_paths += %W(#{config.root}/app)
    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]

    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get,
            :post, :put, :delete, :options]
      end
    end
  end
end
