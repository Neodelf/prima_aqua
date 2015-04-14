class District < ActiveRecord::Base
  validates_presence_of :name
  after_save :set_coord

  def self.search(search)
    if search
      where('lower(name) LIKE ?', "%#{search.downcase}%")
    else
      all
    end
  end

  private
  def set_coord
    if self.lat.blank? && self.lon.blank?
      url = "http://geocode-maps.yandex.ru/1.x/?format=json&geocode=#{d.name.split.join('+')}&ll=30.327541,59.936952&spn=2,2&rspn=1"
      response = JSON.parse(Net::HTTP.get_response(URI.parse(URI.encode(url))).body)
      d.lon, d.lat = if response['response']['GeoObjectCollection']['featureMember'].present?
                       response['response']['GeoObjectCollection']['featureMember'][0]['GeoObject']['Point']['pos'].split
                     else
                       [0,0]
                     end
      d.save
    end
  end
end