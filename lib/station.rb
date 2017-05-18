# class Station
class Station
  attr_reader :name, :zone
  def initialize(name = :no_name, zone = :no_zone)
    @name = name
    @zone = zone
  end
end
