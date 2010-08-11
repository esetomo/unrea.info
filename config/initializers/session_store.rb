# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_esetomo_test_session',
  :secret      => 'ca34eea4ee580ce6b983da2e451165f4e2536ecfd89334ee22dd912da3ebf9b794bf4314ff0297c5aa3dd50b13072b85267ddf6fa4b4d2510cb6381ff99f9161'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
