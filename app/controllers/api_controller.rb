class ApiController < ApplicationController

  before_filter :check_api_version
  protect_from_forgery with: :null_session

  respond_to :xml, :json

  protected

  rescue_from ApiErrorHandling::Exceptions::BaseException, :with => :rescue_api_error

  def rescue_api_error(e)
    logger.error "An error was encountered in the API. Exception: #{e.inspect}"
    @exception = e
    @ex_class = e.class
    @error_message = @exception.message.blank? ? @ex_class::DESCRIPTION : @exception.message
    render :json => {:error => @error_message, :status => @ex_class::STATUS}
  end

  private

  def check_api_version
    raise ApiErrorHandling::Exceptions::UnsupportedVersionException, "Invalid API version #{params[:api_version]}" unless params[:api_version].to_i == 1
  end

end
