require File.expand_path('../boot', __FILE__)
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Chucky
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # CORS config
    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end


    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Mexico City'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # ver:
    # https://github.com/collectiveidea/delayed_job#rails-42
    # http://guides.rubyonrails.org/active_job_basics.html#setting-the-backend
    config.active_job.queue_adapter = :delayed_job

    # Para que los request sean via https
    #config.middleware.use Rack::SslEnforcer, only_environments: ['production'], ignore: %r{/assets}, strict: true#, before_redirect: Proc.new { |request|
       #keep flash on redirect. NO ME FUNCIONA NIGUNA DE LAS DOS LINEAS
       #request.session[:flash].keep if !request.session.nil? && request.session.key?('flash') && !request.session['flash'].empty?
       #flash.keep if !request.session.nil? && request.session.key?('flash') && !request.session['flash'].empty?
     #}

    # scaffold generetors customization by Mati
    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
      g.test_framework  :test_unit, fixture: false
      g.stylesheets     false
      g.javascripts     false
      g.jbuilder        false
    end

    # para cargar los path de modelos que pongo en sudirectoios de app/models/xxx
    # No uso namespaces para los modelos porque no me parece una buena solución al perder ciertas conventions de rails
    config.autoload_paths += %W( #{config.root}/app/models/api #{config.root}/app/models/admin #{config.root}/app/models/dev #{config.root}/app/models/importers)
  end
end
