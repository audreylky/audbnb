Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_KEY'], ENV['FACEBOOK_APP_SECRET'],
  scope: 'email, user_birthday',
  info_fields: 'email, name, gender, birthday', 
  display: 'popup'
end
# https://developers.facebook.com/docs/facebook-login/permissions#