Geocoder.configure(
  :lookup => :bing,
  :api_key => ENV["BING_KEY"],
  :ip_lookup => :maxmind,
  :bing => { :api_key => ENV["BING_KEY"] },
  :maxmind => { :api_key => ENV["MAXMIND_GEOIP_CITY"], :service => :city },
  :timeout => 10,
  :use_https => false,
  :language => :en)

# # geocoding service (see below for supported options):
# Geocoder::Configuration.lookup = :maxmind
# Geocoder::Configuration.ip_lookup = :ip_maxmind

# # to use an API key:
# # FIXME:Need to move this to a different key in production
# Geocoder::Configuration.api_key = ENV["MAXMIND_GEOIP_CITY"]

# # geocoding service request timeout, in seconds (default 3):
# Geocoder::Configuration.timeout = 10

# # use HTTPS for geocoding service connections:
# Geocoder::Configuration.use_https = false

# # language to use (for search queries and reverse geocoding):
# Geocoder::Configuration.language = :en

