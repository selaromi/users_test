JSONAPI.configure do |config|
  #:underscored_key, :camelized_key, :dasherized_key, or custom
  config.json_key_format = :dasherized_key

  #:underscored_route, :camelized_route, :dasherized_route, or custom
  config.route_format = :dasherized_route

  #:basic, :active_record, or custom
  config.operations_processor = :active_record

  config.allowed_request_params = [:include, :fields, :format, :controller, :action, :sort, :page]

  # :none, :offset, :paged, or a custom paginator name
  config.default_paginator = :offset

  # Output pagination links at top level
  config.top_level_links_include_pagination = true

  config.default_page_size = 10
  config.maximum_page_size = 20

  # Output the record count in top level meta data for find operations
  config.top_level_meta_include_record_count = false
  config.top_level_meta_record_count_key = :record_count

  config.use_text_errors = false

  # List of classes that should not be rescued by the operations processor.
  # For example, if you use Pundit for authorization, you might
  # raise a Pundit::NotAuthorizedError at some point during operations
  # processing. If you want to use Rails' `rescue_from` macro to
  # catch this error and render a 403 status code, you should add
  # the `Pundit::NotAuthorizedError` to the `exception_class_whitelist`.
  config.exception_class_whitelist = []

  # Resource Linkage
  # Controls the serialization of resource linkage for non compound documents
  # NOTE: always_include_has_many_linkage_data is not currently implemented
  # config.always_include_has_one_linkage_data = false
end