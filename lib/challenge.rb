require "time"

class Challenge
  attr_reader :earliest_time
  attr_reader :latest_time
  attr_reader :peak_year

  def initialize(file_path)
    @file_path = File.expand_path(file_path)
    @early_year = ''
    @late_year = ''
    @earliest_time = ''
    @latest_time= ''
    @peak_year = ''

    parse()
  end

  def parse
    # Parse the file located at @file_path and set three attributes:
    #
    # earliest_time: the earliest time contained within the data set
    # latest_time: the latest time contained within the data set
    # peak_year: the year with the most number of timestamps contained within the data set

    year_arr = []

    # Opening and running through each line of the file of dates
    File.open(@file_path).each do |date|
      
      # Parsing file and converting necessary parts of the datetime strings
      timestamp = Time.parse(date).to_i
      year = Time.parse(date).strftime("%Y")
      year_arr.push(year)

      earliest(timestamp)
      latest(timestamp)

    end
    peak_years(year_arr)
    
  end

  def earliest (timestamp)
    #@early_year = timestamp < @early_year ? timestamp : early_year
    if @early_year == '' || timestamp < @early_year
      @early_year = timestamp
      @earliest_time = Time.at(timestamp).utc
    end
  end

  def latest (timestamp)
    if @late_year == '' || timestamp > @late_year
      @late_year = timestamp
      @latest_time = Time.at(timestamp).utc
    end
  end

  def peak_years (year_arr)
    # Run through year_arr array and add up how many times each year exists
    track_year_arr = Hash.new(0)
    year_arr.each { |year|
      track_year_arr[year] += 1
    }
    # Find the year with the most entries
    largest_year = track_year_arr.max{|a,b| a[1] <=> b[1]}[0]
    @peak_year = largest_year.to_i
  end

end

#@challenge = Challenge.new("../data/timestamp2.txt")