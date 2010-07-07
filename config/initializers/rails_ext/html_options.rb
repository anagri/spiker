ActiveRecord::Base.class_eval do
  def self.html_options
    all.sort do |champion, challenger|
      champion.name <=> challenger.name
    end.collect do |model|
      [model.name, model.id]
    end
  end
end