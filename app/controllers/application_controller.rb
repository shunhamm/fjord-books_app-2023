# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sigh_up, keys: %i[address self_introduction])
    devise_parameter_sanitizer.permit(:edit, keys: %i[address self_introduction])
  end
  before_action :authenticate_user!
end
