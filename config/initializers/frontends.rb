# frozen_string_literal: true

Rails.application.configure do
  if ENV['FRONTEND'] and not ENV['FRONTEND'].empty?
    config.x.frontends = ENV['FRONTEND'].split('|')
    config.x.frontend_default = config.x.frontends.first
  else
    config.x.frontends = []
    config.x.frontend_default = nil
  end
end
