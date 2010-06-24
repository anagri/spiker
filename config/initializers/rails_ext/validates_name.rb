ActiveRecord::Base.class_eval do
  def self.validates_name
    validates_uniqueness_of :name
    validates_length_of :name, :maximum => 30, :allow_nil => true, :allow_blank => true #checking for nil|blank in presence of
    validates_presence_of :name
  end
end