module FacetHelper
  include Blacklight::FacetsHelperBehavior

    ##
  # Standard display of a facet value in a list. Used in both _facets sidebar
  # partial and catalog/facet expanded list. Will output facet value name as
  # a link to add that to your restrictions, with count in parens.
  #
  # @param [Blacklight::SolrResponse::Facets::FacetField]
  # @param [String] facet item
  # @param [Hash] options
  # @option options [Boolean] :suppress_link display the facet, but don't link to it
  # @return [String]
  def render_facet_value(facet_solr_field, item, options ={})
    path = search_action_path(add_facet_params_and_redirect(facet_solr_field, item))
    content_tag(:span, :class => "facet-label") do
      link_to_unless(options[:suppress_link], facet_display_value(facet_solr_field, item), path, :class=>"facet_select")
    end + render_facet_count(item.hits)
  end


    ##
  # the name of the partial to use to render a facet field.
  #
  # @return [String]
  def facet_partial_name(display_facet = nil)
    config = facet_configuration_for_field(display_facet.name)
    name = config.try(:partial)
    name ||= "facet_pivot" if config.pivot
    name ||= "facet_limit"
  end

end