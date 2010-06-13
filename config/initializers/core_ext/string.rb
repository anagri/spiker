class String
  def modelize
    decontrolled.singularize.to_sym
  end

  def decontrolled
    demodulize.gsub("Controller", "").downcase
  end
end