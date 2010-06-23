def process(str)
  if str =~ /^(.)\s(.*)$/
    case $1
      when 'e'
        eval($2)
      when 't'
        t($2)
      else
        raise "Cannot Process parameter #{str}"
    end
  else
    str
  end
end