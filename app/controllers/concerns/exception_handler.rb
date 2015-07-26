module ExceptionHandler
  extend ActiveSupport::Concern
  included do
    rescue_from(ActiveRecord::RecordInvalid) do |record_invalid_exception|
      render json: JSONAPI::Exceptions::SaveFailed.errors
                     .new(:unprocessable_entity, record_invalid_exception.record.errors), status: :unprocessable_entity
    end

    rescue_from(ActiveRecord::RecordNotUnique) do |record_not_unique|
      render json: JSONAPI::ErrorsOperationResult.new(:unprocessable_entity, ['RECORD_NOT_UNIQUE']), status: :unprocessable_entity
    end
  end

end

