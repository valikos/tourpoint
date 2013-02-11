# geocoding service (see below for supported options):
Geocoder::Configuration.lookup = :bing

# to use an API key:
# FIXME:Need to move this to a different key in production
Geocoder::Configuration.api_key = ENV["MAXMIND_GEOIP_CITY"]

# geocoding service request timeout, in seconds (default 3):
Geocoder::Configuration.timeout = 10

# use HTTPS for geocoding service connections:
Geocoder::Configuration.use_https = false

# language to use (for search queries and reverse geocoding):
Geocoder::Configuration.language = :en
