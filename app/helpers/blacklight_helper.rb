module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior

 ##
  # Render the index field label for a document
  #
  # @overload render_index_field_value(options)
  #   Use the default, document-agnostic configuration
  #   @param [Hash] opts
  #   @options opts [String] :field
  #   @options opts [String] :value
  #   @options opts [String] :document
  # @overload render_index_field_value(document, options)
  #   Allow an extention point where information in the document
  #   may drive the value of the field
  #   @param [SolrDocument] doc
  #   @param [Hash] opts
  #   @options opts [String] :field 
  #   @options opts [String] :value
  # @overload render_index_field_value(document, field, options)
  #   Allow an extention point where information in the document
  #   may drive the value of the field
  #   @param [SolrDocument] doc
  #   @param [String] field
  #   @param [Hash] opts
  #   @options opts [String] :value
  def render_index_field_value *args
    options = args.extract_options!
    document = args.shift || options[:document]
    field = args.shift || options[:field]
    (custom_field(field, document)) || (presenter(document).render_index_field_value field, options)
  end

  def custom_field(field, document)
    case field
    when 'id'
      return link_to("#{document.id} (View in DPLA Hub)", "http://dpla.hub/records/"+ document.id)
    end
    false
  end
end