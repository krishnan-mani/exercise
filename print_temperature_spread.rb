#!/Users/km/.rvm/rubies/ruby-1.9.3-p286/bin/ruby

class WeatherInfo
  include Comparable
  attr_reader :day, :max_temp, :min_temp

  def initialize(data_str)
    data_split = data_str.split(' ')
    @day = data_split[0].to_i
    @max_temp = data_split[1].to_i
    @min_temp = data_split[2].to_i
  end

  def to_s
    "weather on day #{day} highest temperature #{max_temp}, lowest temperature #{min_temp}"
  end

  def <=>(other)
    other.spread <=> spread
  end

  def spread; max_temp - min_temp; end
end

weather_data_parsed = []
File.open('weather.dat').each do |file|
  lines = file.lines
  lines.each do |line|
    weather_data_parsed << WeatherInfo.new(line)
  end
end

valid_data = weather_data_parsed.slice(2, weather_data_parsed.length)

highest_spread = valid_data.sort.last
print "Least temperature spread on day #{highest_spread.day} has least spread #{highest_spread.spread}"
print "\n"

coldest_day = (valid_data.sort { |a, b| a.min_temp <=> b.min_temp })[0]
print "Coldest day #{coldest_day.day}, temperature dropped to  #{coldest_day.min_temp}"
print "\n"

hottest_day = (valid_data.sort { |a, b| b.max_temp <=> a.max_temp })[0]
print "Hottest day #{hottest_day.day}, mercury soared to #{hottest_day.max_temp}"
print "\n"
