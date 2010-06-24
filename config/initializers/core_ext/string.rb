class String
  def modelize
    decontrolled.singularize.to_sym
  end

  def decontrolled
    demodulize.gsub("Controller", "").underscore
  end

  def convert_to_time
    str_arr = split(".")
    time = str_arr.shift.to_i
    str_arr.each {|str| time = time.send str.to_sym}
    time
  end
end