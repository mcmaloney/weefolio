# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_weefolio_session',
  :secret      => 'eb9c39a117741e1634654164c8b036f5b39ee7a975feffe5db4b8c186ce5e54802ac605335d1c4d9a0b1fe80d68ae95d6d0235e0c86875f255e45a8be174d798'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
