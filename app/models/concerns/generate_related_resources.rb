require_relative '../../../app/errors/custom_errors'

module GenerateRelatedResources
  attr_writer :relationships

  CREATE_BEFORE_SAVE = []

  CREATE_AFTER_SAVE = []


  def relationships
    @relationships ? @relationships : []
  end

  # until nested resource creation is manged correctly by json-api, we'll generate
  def generate_nested_resources option
    @generated_models = []
    case option
      when :before

      when :after
        relationships.each do |nested_resource_hash|
          target_class_name = nested_resource_hash.first[0].to_s
          target_class = target_class_name.humanize.constantize
          case nested_resource_hash.first[1]
            when Array
              nested_resource_hash.first[1].each do |element|
                @generated_model = target_class.new(element)
                @generated_model.save!
                send("#{target_class_name.downcase}<<",@generated_model)
              end
            when Hash
              @generated_model = Profile.create(nested_resource_hash.first[1])
              @generated_model.save!
              send("#{target_class_name.downcase}=",@generated_model)
              @generated_models << @generated_model
          end
        end
    end
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
    destroy
    raise JSONAPI::Exceptions::CustomValidationErrors.new(e)
  end
end
