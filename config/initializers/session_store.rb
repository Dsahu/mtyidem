# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_idemsport_session',
  :secret      => 'b1a80a12f02fee4751dfb1dcf7f80dc0044cf891c10a0c670bbbf4042b7e718d7c51b08c60aceab1f4958da3304bb925c92707e4e955bc77b5691d9f206c9e6d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
