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
      url = "http://geocode-maps.yandex.ru/1.x/?format=json&geocode=#{self.name}&ll=59.936952,30.327541&spn=3,3"
      response = JSON.parse(Net::HTTP.get_response(URI.parse(URI.encode(url))).body)
      self.lon, self.lat = response['response']['GeoObjectCollection']['featureMember'][0]['GeoObject']['Point']['pos'].split
      self.save
    end
  end
end