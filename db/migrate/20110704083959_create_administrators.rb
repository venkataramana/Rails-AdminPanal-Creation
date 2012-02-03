class CreateAdministrators < ActiveRecord::Migration
  def self.up
    create_table :administrators do |t|
      t.string :admin_name
      t.string :username
      t.string :password
      t.string :gender
      t.date :dob

      t.timestamps
    end
  end

  def self.down
    drop_table :administrators
  end
end
