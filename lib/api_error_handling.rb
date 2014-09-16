module ApiErrorHandling

  module Exceptions

    class BaseException < StandardError
      STATUS = 500
      CODE = :unknown_error
      DESCRIPTION = "Unknown API error occurred."
    end

    class UnsupportedVersionException < BaseException
      STATUS = 400
      CODE = :api_version_unsupported
      DESCRIPTION = "API version not defined, or unsupported version defined."
    end

    class MissingParametersError < BaseException
      STATUS = 400
      CODE = :missing_parameters
      DESCRIPTION = "The request is missing some of the mandatory parameters defined in the API specification."
    end

    class AuthenticationError < BaseException
      STATUS = 403
      CODE = :invalid_authentication_credentials
      DESCRIPTION = "Incorrect authentication credentials."
    end

    class ResourceNotFoundException < BaseException
      STATUS = 404
      CODE = :resource_not_found
      DESCRIPTION = "The requested resource was not found."
    end

  end

end
