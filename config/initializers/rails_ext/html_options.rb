ActiveRecord::Base.class_eval do
  def self.html_options
    all.collect {|model| [model.name, model.id]}
  end
end