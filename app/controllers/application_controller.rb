require_relative 'concerns/exception_handler'

class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  include JSONAPI::ActsAsResourceController
  # include ExceptionHandler
  skip_before_filter :ensure_correct_media_type
  skip_after_filter :setup_response
  respond_to :json


end
