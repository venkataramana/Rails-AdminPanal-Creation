class User < ActiveRecord::Base
        validates_presence_of :name, :email, :address
        validates_length_of :name, :minimum => 5, :allow_nil => true, :allow_blank => true
        validates_uniqueness_of :email
        validates_format_of :email, :with => /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/, :allow_nil => true, :allow_blank => true
end

