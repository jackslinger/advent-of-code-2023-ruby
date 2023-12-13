file = File.read("./day6/example.txt")
# file = File.read("./day6/input.txt")

times, distances = file.split("\n")
times = times.split(/\s+/).drop(1)
distances = distances.split(/\s+/).drop(1)

class Race
  attr_reader :time, :record
  
  def initialize(time, record)
    @time = time
    @record = record
  end
end

races = times.zip(distances).map{ |race| Race.new(race.first, race.last) }
