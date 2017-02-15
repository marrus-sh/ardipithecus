# frozen_string_literal: true

class PortalController < ApplicationController

  def index
    @title = Setting.site_title
  end

end
