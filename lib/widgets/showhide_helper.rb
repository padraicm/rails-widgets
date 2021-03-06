module Widgets
  module ShowhideHelper
    include CssTemplate

    def show_box_for record, opts={}
      name = opts[:name] || 'details'
      link_name = opts[:link_name] || 'show details'
      detail_box_id = opts[:detail_box_id] || dom_detail_id(record,name)
      hide_link_id = opts[:hide_link_id] || dom_hide_id(record,name)

      html = opts[:html] || {} # setup default html options
      html[:id] ||= dom_show_id(record, name)
      html[:class] ||= "#{name}_show_link"

      link_to_function link_name, nil, html do |page|
        page[detail_box_id].show
        page[html[:id]].hide
        page[hide_link_id].show
      end
    end

    def hide_box_for record, opts={}
      name = opts[:name] || 'details'
      link_name = opts[:link_name] || 'hide details'
      detail_box_id = opts[:detail_box_id] || dom_detail_id(record,name)
      show_link_id = opts[:show_link_id] || dom_show_id(record,name)

      html = opts[:html] || {} # setup default html options
      html[:id] ||= dom_hide_id(record,name)
      html[:class] ||= "#{name}_hide_link"
      html[:style] ||= ""
      html[:style] += "display:none;"

      link_to_function link_name, nil, html do |page|
        page[detail_box_id].hide
        page[show_link_id].show
        page[html[:id]].hide
      end
    end

    def detail_box_for record, opts={}, &block
      raise ArgumentError, 'Missing block in showhide.detail_box_for call' unless block_given?
      name = opts[:name] || 'details'
      @generate_css = opts[:generate_css] || false

      html = opts[:html] || {} # setup default html options
      html[:id] ||= dom_detail_id(record,name)
      html[:class] ||= "#{name}_for_#{normalize_class_name(record)}"
      html[:style] = 'display:none;'
      @css_class = html[:class]
      concat(render_css('showhide')) if generate_css?
      # Taken from ActionView::Helpers::RecordTagHelper
      concat content_tag(:div, capture(&block), html)
      nil
    end

    private

    def dom_detail_id record, name
      normalize_dom_id(record, name.to_s)
    end

    def dom_show_id record, name
      normalize_dom_id(record, "show_#{name}")
    end

    def dom_hide_id record, name
      normalize_dom_id(record, "hide_#{name}")
    end

    def normalize_dom_id object, prefix
      if object.kind_of?(ActiveRecord::Base)
        dom_id(object, "#{prefix}_for#{object.new_record? ? '_new' : ''}")
      else
        new_record = ''
        if object.respond_to?(:new_record?)
          new_record = 'new_' if object.new_record?
        end
        object_id = ''
        if object.respond_to?(:attributes)
          object_id = "_#{object.attributes[:id]}" if object.attributes[:id]
        end
        [ prefix, 'for', new_record << normalize_class_name(object) << object_id ].compact * '_'
      end
    end

    def normalize_class_name object
      if object.kind_of?(ActiveRecord::Base)
        ActionController::RecordIdentifier.singular_class_name(object)
      else
        object.to_s
      end
    end

    # content_tag_for creates an HTML element with id and class parameters
    # that relate to the specified Active Record object.
    #
    # Taken from ActionView::Helpers::RecordTagHelper
    def content_box_for(tag_name, *args, &block)
      concat content_tag(tag_name, capture(&block), args)
    end
  end
end
