module CustomValidations
  # Validate a SSN
  def validates_ssn(*attr_names)
    attr_names.each do |attr_name|
      validates_format_of attr_name,
        :with => /\A[\d]{3}-[\d]{2}-[\d]{4}\z/,
        :message => "must be of format ###-##-####"
    end
  end
  
  # Makes sure an email address at least looks like an email address
  def validates_email_address(*attr_names)
    attr_names.each do |attr_name|
      validates_format_of attr_name,
        :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/,
        :message => "must be a valid email address"
    end
  end
end
ActiveRecord::Base.extend(CustomValidations)