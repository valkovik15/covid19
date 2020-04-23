# frozen_string_literal: true

module Covid19
  class APICallError < StandardError; end
  class NotFoundError < APICallError; end
  class APIKeyError < APICallError; end
end
