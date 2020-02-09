class ApplicationController < ActionController::Base
  include Pundit

  unless Rails.application.config.consider_all_requests_local
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from Pundit::NotAuthorizedError, with: :render_unauthorized_response
    rescue_from ActionController::RoutingError, with: :error_generic
  end

  private

  def render_unprocessable_entity_response(exception)
    render json: {
      message: "Validation Failed",
      errors: ValidationErrorsSerializer.serialize(exception.record)
    }, status: :unprocessable_entity
  end

  def render_unauthorized_response(error)
    render json: {
      message: "Unauthorized",
      errors: error
    }, status: :unauthorized
  end

  def error_generic(error)
    render json: {
      message: "Bad request",
      errors: error
    }, status: :bad_request
  end
end
