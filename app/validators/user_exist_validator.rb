class UserExistValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless User.find_by name: value
      record.errors[attribute] << (options[:message] || "user with name #{value.inspect} doesn't exist")
    end
  end
end
