# frozen_string_literal: true

module Notion
  module Api
    module Endpoints
      module Pages
        #
        # Retrieves a 📄Page object  using the ID specified in the request path.
        # Note that this version of the API only exposes page properties, not page content
        #
        # @option options [id] :page_id
        #   Page to get info on.
        #
        # @option options [bool] :archived
        #   Set to true to retrieve an archived page; must be false or omitted to
        #   retrieve a page that has not been archived. Defaults to false.
        def page(options = {})
          throw ArgumentError.new('Required argument :page_id missing') if options[:page_id].nil?
          get("pages/#{options[:page_id]}")
        end

        #
        # Creates a new page in the specified database or as a child of an existing page.
        # If the parent is a database, the property values of the new page in the properties parameter must conform to the parent database's property schema.
        # If the parent is a page, the only valid property is title.
        # The new page may include page content, described as blocks in the children parameter.
        #
        # @option options [Object] :parent
        #   A database parent or page parent
        #
        # @option options [Object] :properties
        #   Property values of this page. The keys are the names or IDs of the property and the values are property values.
        #
        # @option options [Array] :children
        #   Page content for the new page as an array of block objects
        #
        # @option options [Object] :icon
        #   Page icon for the new page.
        #
        # @option options [Object] :cover
        #   Page cover for the new page
        def create_page(options = {})
          throw ArgumentError.new('Required argument :parent.database_id missing') if options.dig(:parent, :database_id).nil? && options.dig(:parent, :page_id).nil?
          post("pages", options)
        end

        #
        # Updates a page by setting the values of any properties specified in the
        # JSON body of the request. Properties that are not set via parameters will
        # remain unchanged.
        #
        # Note that this iteration of the API will only expose page properties, not page
        # content, as described in the data model.
        #
        # @option options [id] :page_id
        #   Page to get info on.
        #
        # @option options [Object] :properties
        #   Properties of this page.
        #   The schema for the page's keys and values is described by the properties of
        #   the database this page belongs to. key string Name of a property as it
        #   appears in Notion, or property ID. value object Object containing a value
        #   specific to the property type, e.g. {"checkbox": true}.
        def update_page(options = {})
          throw ArgumentError.new('Required argument :page_id missing') if options[:page_id].nil?
          patch("pages/#{options[:page_id]}", options.except(:page_id))
        end

        #
        # Retrieves a `property_item` object for a given `page_id` and `property_id`.
        # Depending on the property type, the object returned will either be a value
        # or a paginated list of property item values.
        #
        # @option options [id] :page_id
        #   Page to get info on.
        #
        # @option options [id] :property_id
        #   Property to get info on.
        #
        def page_property_item(options = {})
          throw ArgumentError.new('Required argument :page_id missing') if options[:page_id].nil?
          throw ArgumentError.new('Required argument :property_id missing') if options[:property_id].nil?
          get("pages/#{options[:page_id]}/properties/#{options[:property_id]}")
        end
      end
    end
  end
end
