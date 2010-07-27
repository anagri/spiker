module FormHelper
  def disabled(record)
    record.new_record? ? {} : {:disabled => 'disabled'}
  end

  def submit_caption(record)
    record.new_record? ? t("view.#{record.class.name.tableize}.create", :default => :'view.common.create') : t("view.#{record.class.name.tableize}.update", :default => :'view.common.update')
  end

  def input_text(form_builder, field, options)
    text_tag_output(form_builder, field, :text_field, options)
  end

  def password_text(form_builder, field, options)
    text_tag_output(form_builder, field, :password_field, options)
  end

  private
  def text_tag_output(form_builder, field, method, options)
    text_field_options = {:class => "desc #{options.delete(:focus) ? 'focus' : ''}"}
    label_options = {:class => 'desc'}
    label_options.merge!(:required => true) if options.delete(:required)

    error_class = form_builder.error_class(field)
    error_message = form_builder.error_message_on(field, :css_class => 'field_error')

    %Q{<li class="#{error_class}">
      #{form_builder.label field, nil, label_options}
      <span>
        #{form_builder.send(method, field, text_field_options)}
      </span>#{error_message}
    </li>}
  end
end