require 'facebook_graphr'
if defined?(Rails)
  require 'facebook_graphr/controller'
  require 'facebook_graphr/helpers'
  ActionController::Base.send(:helper, FacebookGraphr::Helpers::Init)
  ActionController::Base.send(:include, FacebookGraphr::Helpers::FBML)
  ActionController::Base.send(:helper, FacebookGraphr::Helpers::FBML)
  ActionController::Base.send(:include, FacebookGraphr::Rails::Controller)
end
