object false

node(:meta) do
  {
    access_token: @token,
    locale: I18n.locale,
    router_basename: "/go",
    me: current_account.id,
  }
end

node(:site) do
  {
    title: Setting.site_title,
    links: {
      t('about.about') => "/about",
      t('auth.logout') => "/auth/sign_out"
    }
  }
end

node(:compose) do
  {
    me: current_account.id,
    default_privacy: current_account.user.setting_default_privacy,
    max_chars: Rails.application.config.x.max_chars
  }
end

node(:accounts) do
  {
    current_account.id => partial('api/v1/accounts/show', object: current_account),
  }
end

node(:settings) { @web_settings }
