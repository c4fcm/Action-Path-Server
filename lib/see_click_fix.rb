require 'open-uri'

class SeeClickFix

  BASE_URL = "https://seeclickfix.com/api/v2/"

  PLACE_TYPE_CITY = "City"

  def self.places_near(lat,lng)
    url = BASE_URL + "places?" + {:lat=>lat,:lng=>lng,:per_page=>50 }.to_query
    JSON.load(open(url))
  end

end