# frozen_string_literal: true

class AboutController < ApplicationController

  def index
    @user_count   = Rails.cache.fetch('user_count')            { User.count }
    @status_count = Rails.cache.fetch('local_status_count')    { Status.local.count }
    @domain_count = Rails.cache.fetch('distinct_domain_count') { Account.distinct.count(:domain) }
  end
  def mission; end
  def principles; end
  def terms; end
  def privacy; end

end
