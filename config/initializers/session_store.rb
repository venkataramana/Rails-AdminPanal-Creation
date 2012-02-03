# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_New_Admin_session',
  :secret      => '1165a0b8cc46e93bfac7b9aacd177482a569dcf1e1942a08970c9faaabd3d29d6dd5366ae9e7b49c3735e88468c1ec7f1018ebe47be69a2361aa6ad233b1acc6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
