module ActionView::Helpers
  class FormBuilder
    def button(value = "Save", options = {})
      options = {:type => 'submit',
                 :class => 'button'}.merge(options)
      %Q{<button class="#{options[:class]}" type="#{options[:type]}">
      <img src="images/web-app-theme/key.png" alt="#{value}">#{value}</img>
    </button>}
    end

    def error_class(field_name)
      have_errors?(field_name) ? 'error' : ''
    end

    def have_errors?(field_name)
      !error_message_on(:base).blank? || !error_message_on(field_name).blank?
    end
  end
end
