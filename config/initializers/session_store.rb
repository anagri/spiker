# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_spiker_session',
  :secret      => 'adaa64b9ef6a9c66049e16daac107e1d852067fdd5870e116570937b79da554e7bdbfd8a0f679f962afd469f1a642a8cbf483bea34cdb2935e9ff94ace85bd4d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
