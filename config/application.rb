require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ReminderApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

Rails.application.configure do
  config.generators do |g|
    g.test_framework :rspec, fixture: true
    g.fixture_replacement :factory_girl, dir: 'spec/factories'
    g.view_specs false
    g.helper_specs false
    g.stylesheets = false
    g.javascripts = false
    g.helper = false
  end

  config.autoload_paths += %W(\#{config.root}/lib)

  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
end