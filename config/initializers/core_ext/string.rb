class String
  def modelize
    demodulize.gsub("Controller", "").downcase.singularize.to_sym
  end
end