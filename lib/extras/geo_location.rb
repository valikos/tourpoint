module GeoLocation

  def parse_lookups(lookup)
    self.send(Geocoder.config.lookup, :lookups => Geocoder.search(lookup))
  end

  def google( option = {} )
    results = []
    option[:lookups].each do |res|
      results << { :name => res.formatted_address, :position => res.geometry["location"] }
    end
    results
  end

  def bing( option = {} )
    results = []
    option[:lookups].each do |res|
      results << { :name => res.name,
        :position => { :lat => res.coordinates.first, :lng => res.coordinates.last } }
    end
    results
  end
end
