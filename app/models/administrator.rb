        require 'digest/sha1'
        class Administrator < ActiveRecord::Base
                  validates_presence_of :admin_name, :username, :password, :gender, :dob
                  validates_uniqueness_of :username
                  validates_length_of :username, :admin_name, :minimum => 4, :allow_nil => true, :allow_blank => true
                  validates_length_of :password, :in => 4..12, :allow_nil => true, :allow_blank => true

                  #password is a virtual attribute (not stored in the database)
                  def password
                        @password
                  end
                  def password=(pwd)
                         @password = pwd
                         return if pwd.blank?
                         create_new_salt
                         self.salt = Administrator.random_string(10) if !self.salt?
                         self.hashed_password = Administrator.encrypted_password(self.password, self.salt)
                  end

                  def self.authenticate(username, password)
                        user = self.find_by_username(username)
                        return nil if user.nil?
                        return user if Administrator.encrypted_password(password, user.salt)==user.hashed_password
                  end

                private

                  def password_non_blank
                        errors.add(:password, "Password can't be blank") if hashed_password.blank?
                  end

                  def create_new_salt
                        self.salt = self.object_id.to_s + rand.to_s
                  end

                  def self.encrypted_password(password, salt)
                        string_to_hash = password + "fish_and_chips_with_vinegar" + salt
                        Digest::SHA1.hexdigest(string_to_hash)
                  end
        end

