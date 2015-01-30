module ApplicationHelper

  def errors_for(model, attribute)
    if model.errors[attribute].present?
      content_tag :span, class:'error-explanation' do
        attribute_name = model.class.human_attribute_name(attribute)
        attribute_name + ' ' + model.errors[attribute].join(", " + attribute_name + " ")
      end
    end
  end

  def formatted_phone model
    model.phone == nil ? '' : '(' + model.area_code + ') ' + model.phone_prefix + '-' + model.phone_suffix
  end

end
