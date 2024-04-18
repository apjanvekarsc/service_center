class ArrayAsCsv

  # read the commma separated list of values, and conver to an array
  def self.load(value)
    return [] unless value.present?
    value.split(',')
  end

  # convert to a comma separated list of values, for storing in the database
  def self.dump(value)
    return nil unless value.is_a? Array
    value.reject!(&:blank?)
    value.join(',')
  end

end
