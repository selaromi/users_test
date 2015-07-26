module JSONAPI
  module Exceptions

    class CustomValidationErrors < Error
      attr_reader :error_messages

      def initialize(resource)
        @error_messages = resource.record.errors.messages
        @resource_relationships = []
        @key_formatter = JSONAPI.configuration.key_formatter
      end

      def format_key(key)
        @key_formatter.format(key)
      end

      def errors
        error_messages.flat_map do |attr_key, messages|
          messages.map { |message| json_api_error(attr_key, message) }
        end
      end

      private

      def json_api_error(attr_key, message)
        JSONAPI::Error.new(code: JSONAPI::VALIDATION_ERROR,
                           status: :unprocessable_entity,
                           title: "#{format_key(attr_key)} - #{message}",
                           detail: message)

      end
    end
  end
end
