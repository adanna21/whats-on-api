class ApplicationRecord < ActiveRecord::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods
end
