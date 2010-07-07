module TreeHelper
  def tree(resources)
    return tree([resources]) unless resources.is_a? Array
    return '' if resources == []
    out = "<ul>\n"
    resources.each {|resource|
      config = HashWithIndifferentAccess.new({
              :html_id => "#{resource.class.name}-#{resource.id}",
              :path => office_path(resource.id)
      });

      out << "<li><span id=\"#{config[:html_id]}\">" << surround_with_link(config[:path]) {resource.name} << "</span>\n"
      out << tree(resource.children)
      out << "</li>\n"
    }
    out << "</ul>\n"
  end

  def surround_with_link(path)
    if path
      "<a href=\"#{path}\">" << yield << "</a>"
    else
      yield
    end
  end
end