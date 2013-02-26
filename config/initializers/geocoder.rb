# geocoding service (see below for supported options):
Geocoder::Configuration.lookup = :google

# to use an API key:
# FIXME:Need to move this to a different key in production
Geocoder::Configuration.api_key = ENV["GOOGLE_KEY"]

# geocoding service request timeout, in seconds (default 3):
Geocoder::Configuration.timeout = 5

# use HTTPS for geocoding service connections:
Geocoder::Configuration.use_https = false

# language to use (for search queries and reverse geocoding):
Geocoder::Configuration.language = :en
