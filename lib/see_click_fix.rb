require 'open-uri'

class SeeClickFix

  BASE_URL = "https://seeclickfix.com/api/v2/"

  ROLE_VERIFIED_OFFICIAL = "Verified Official"
  
  PLACE_TYPE_CITY = "City"

  DEFAULT_ZOOM = 12
  DEFAULT_PER_PAGE = 100
  DEFAULT_STATUS = 'open'
  DEFAULT_SORT = 'updated_at'

  def self.place(place_id)
    url = BASE_URL + "places/" + place_id.to_s
    self._load_json_from url
  end

  def self.places_near(lat,lng)
    url = BASE_URL + "places?" + {:lat=>lat,:lng=>lng,:per_page=>50 }.to_query
    self._load_json_from url
  end

  def self.request_type(request_type_id)
    # https://seeclickfix.com/api/v2/request_types/122
    url = BASE_URL + "request_types/" + request_type_id
    self._load_json_from url
  end

  def self.issues_near(lat,lng,request_types,status=DEFAULT_STATUS,sort=DEFAULT_SORT,zoom=DEFAULT_ZOOM)
    # https://seeclickfix.com/api/v2/issues?lat=41.3100&lng=-72.9236&zoom=14&per_page=10&status=open,acknowledged&sort=updated_at&request_types=116
    url = BASE_URL + "issues?" + {
      :lat=>lat, :lng=>lng, :request_types=>request_types, 
      :zoom=>zoom, :per_page=>100, :status=>status, :sort=>sort }.to_query
    self._load_json_from url
  end

  def self.lastest_issues(place_url)
    url = BASE_URL + "issues?" + {:place_url=>place_url,:per_page=>100}.to_query
    self._load_json_from url
  end

  private

    def self._load_json_from(url)
      Rails::logger.debug("SCF: querying from #{url}")
      JSON.load(open(url))
    end

end