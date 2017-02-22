# Be sure to restart your server when you modify this file.

# Adds support for Literate CoffeeScript & Literate CoffeeScript + ERB

module LitCoffeeTransformer
  def self.call(input)
    tilter = Tilt::CoffeeScriptLiterateTemplate.new input[:filename], input[:data]
    {data: tilter.render}
  end
end
Sprockets.register_mime_type 'text/literate-coffeescript', extensions: ['.litcoffee', '.coffee.md']
Sprockets.register_transformer 'text/literate-coffeescript', 'application/javascript', LitCoffeeTransformer
Sprockets.register_mime_type 'application/x-erb', extensions: ['.litcoffee.erb', '.coffee.md.erb']

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << 'node_modules'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w(application_public.js)
Rails.application.config.assets.precompile += %w(about.css)
Rails.application.config.assets.precompile += %w(depreciated.css)

# Frontend assets
if ENV['FRONTEND'] and not ENV['FRONTEND'].empty?
  for frontend in ENV['FRONTEND'].split("|") do
    Rails.application.config.assets.precompile += [frontend + ".css", frontend + ".js"]
  end
end

Rails.application.config.assets.initialize_on_precompile = true
