class BaseResource < JSONAPI::Resource
  attributes :relationships

  before_save :generate_nested_resources_before
  after_save :generate_nested_resources_after


  def fetchable_fields
    super - [:relationships]
  end

  def generate_nested_resources_before
    @model.generate_nested_resources :before
  end

  def generate_nested_resources_after
    @model.generate_nested_resources :after
  end

end