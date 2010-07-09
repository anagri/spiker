class DecimalAttribute < AdditionalAttribute
  validates_presence_of :length
  validates_presence_of :precision
end