class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  def set_locale
    if params.has_key?(:locale) # If locale-parameter is set, lets store it to session.
      I18n.locale = params[:locale]
    elsif session.has_key?(:locale) # If locale-parameter is not set, lets fetch locale from session
      I18n.locale = session[:locale]
    else # Otherwise, let's use default locale.
      I18n.locale = I18n.default_locale
    end
    session[:locale] = I18n.locale
  end

end
