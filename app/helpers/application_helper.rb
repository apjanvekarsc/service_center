module ApplicationHelper
  def error_message_for(resource, field, options = {:prepend_text => ""})
    error_message = resource.errors[field][0] rescue nil
    if error_message
      raw "#{options[:prepend_text]} #{error_message}"
    end
  end

  def version_ids(resource)
    version_array = []
    version = resource.audits.count
    while version >= 1
      version = version - 1
      version_array << ["Version " + version.to_s, version]
    end
    version_array
  end

  def old_values(values)
    if values.is_a?(Array)
      values[0] rescue nil
    else
      nil
    end
  end

  def new_values(values)
    if values.is_a?(Array)
      values[1] rescue nil
    else
      values
    end
  end

  def audit_count(resource)
    count = resource.audits.count
    count > 0 ? count - 1 : 0
  end 

  def has_route? options
    Rails.application.routes.routes.map{|route| route.defaults}.include?(options)
  end

  def valid_date(date)
    d = Date.strptime(date, '%d-%m-%Y') rescue false
    d != false ? true : false
  end

  def advanced_search_page_links
    capture do
      concat link_to_if @records.previous_page, 'Previous', "javascript:$('#page').val(#{@records.previous_page});$('#advanced_search').submit()"
      concat " "
      concat link_to_if @records.next_page, 'Next', "javascript:$('#page').val(#{@records.next_page});$('#advanced_search').submit()"
    end
  end
  
  def relative_time(timestamp)
    timestamp.present? ? time_ago_in_words(timestamp)+' ago' : '-'
  end
  
  def show_xml(link,class_name,request)
    link_to_unless((current_user.has_role? :customer), link, '#',{:class => class_name, :href => "javascript:void(0);", data: { request: request, reply: request }})
  end
  
  def search_form_for(object, *args, &block) 
    options = args.extract_options!
    
    html1 = content_tag(:h2, class: 'collapsible') do
      ("Advanced Search <span class = 'caret'></span>").html_safe
    end
  
    html2 = content_tag(:div, class: 'collapsible-content') do
      klass = object.class.included_modules.include?(SearchAbility) ? object.class : object.klass
      form_url = options[:url] || polymorphic_path(klass)
      simple_form_for(object, *(args << options.merge(wrapper: :horizontal_form, builder: SearchFormBuilder, html: { class: "form-horizontal"}, autocomplete: "off", disabled: true, url: form_url, method: :put)), &block)
    end
    html1 + html2
  end
  
  def pagination_links(records)
    searcher_klass = @searcher.class.name
    object_name = searcher_klass.underscore
    form_id = "'#new_#{object_name}'"
    page_id = "'##{object_name}_page'"
    content_tag :div do
      concat link_to_if records.previous_page, 'Previous', "javascript:$(#{page_id}).val(#{records.previous_page});$(#{form_id}).submit()"
      concat " "
      concat link_to_if records.next_page, 'Next', "javascript:$(#{page_id}).val(#{records.next_page});$(#{form_id}).submit()"
    end
  end
  
  def fa_icon_tag(name)
    content_tag(:i, nil, class: "fa fa-#{name}")
  end

  def beautify(inputs)
    output = beautify_xml(inputs)
    if output.blank?
      beautify_json(inputs)
    else
      output
    end
  end
  
  def beautify_xml(inputs_xml)
    output_xml = ''
    begin
      xml = REXML::Document.new(inputs_xml)
      xml.write(output_xml, 2)
    rescue
    end
    output_xml
  end

  def beautify_json(inputs)
    begin
      output = JSON.pretty_generate(JSON.parse(inputs))
      output = "#{inputs}" if output.blank?
    rescue
      output = "#{inputs}"
    end

    output
  end
  
  def rp_routes
    Rp::Engine.routes.url_helpers
  end
end