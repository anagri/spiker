module LocaleUtil
  def t(*args)
    if args.first =~ /^\../
      dot_notation = args.shift
      args.unshift("#{self.class.name.decontrolled}.#{self.action_name}#{dot_notation}")
    end
    super
  end
end