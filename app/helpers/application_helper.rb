module ApplicationHelper

  def mailto_link(value)
    "<a href='mailto:#{value}' target='_blank'>#{value}</a>".html_safe unless value.blank?
  end

  def tel_link(value)
    "<a target='_blank' class='tel_link' href='tel:#{value}'>#{value}</a>".html_safe unless value.blank?
  end

  def google_maps_link(address, zip, city, print_only_address = true)
    print_only_address ? address_to_be_printed = address : address_to_be_printed = "#{address}, #{zip} #{city}"
    raw "<a target='_blank' href='https://maps.google.com/?q=#{address}+#{zip}+#{city}'>#{address_to_be_printed}</a>" unless address.blank?
  end

  def label_formatter(field, object, value, full_width = false, without_label = false)
    field_label = without_label ? '' : t("activerecord.attributes.#{object.class.name.downcase}.#{field}")
    raw "<label class='input_value #{full_width ? 'col-sm-2' : 'col-sm-4'} control-label bold #{value.blank? ? 'hide_in_mobile' : ''}'>#{field_label}</label>"
  end

  def value_formatter(value, full_width = false)
    raw "<div class='#{full_width ? 'col-sm-10' : 'col-sm-8'} input_value'><div class='form-control'>#{value}</div></div>"
  end

  def field_formatter(field, object, textarea = false, full_width = false, without_label = false, options = {})
    value = object.send(field)
    label_formatter(field, object, value, full_width, without_label) + value_formatter(textarea ? simple_format(value) : value, full_width)
  end

  def external_link_formatter(field, object, path, classes = '')
    value = object.send(field)
    label_formatter(field, object, value) + value_formatter(value.blank? ? '' : link_to(value, path, :target => :_blank, :class => classes))
  end

  def google_maps_link_formatter(field, object, print_only_address = true)
    label_formatter(field, object, object.address) + value_formatter(google_maps_link(object.address, object.zip, object.city, print_only_address))
  end

  def mail_formatter(field, object, extra_string = nil)
    value = object.send(field)
    label_formatter(field, object, value) + value_formatter(value.blank? ? '' : mailto_link(value) + extra_string)
  end

  def tel_formatter(field, object, label = nil, extra_string = nil)
    value = object.send(field)
    label = field if label.nil?
    label_formatter(label, object, value) + value_formatter(value.blank? ? '' : tel_link(value) + extra_string)
  end

end
