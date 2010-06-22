module TreeHelper
  def tree(resources, depth = 0)
    return tree([resources]) unless resources.is_a? Array
    return "" if resources == []
    out = ""
    resources.each {|resource|
      out << ('&gt;' * depth) << "#{resource.name}" << '<br/>'
      out << tree(resource.children, depth+1)
    }
    out
  end
end