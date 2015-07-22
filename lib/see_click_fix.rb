require 'open-uri'

class SeeClickFix

  BASE_URL = "https://seeclickfix.com/api/v2/"

  PLACE_TYPE_CITY = "City"

  def self.place(place_id)
    url = BASE_URL + "places/" + place_id.to_s
    self._load_json_from url
  end

  def self.places_near(lat,lng)
    url = BASE_URL + "places?" + {:lat=>lat,:lng=>lng,:per_page=>50 }.to_query
    self._load_json_from url
  end

  def self.lastest_issues(place_url)
    url = BASE_URL + "issues?" + {:place_url=>place_url,:per_page=>100}.to_query
    self._load_json_from url
  end

  private

    def self._load_json_from(url)
      JSON.load(open(url))
    end

end