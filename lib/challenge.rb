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

    year_arr = Hash.new(0)

    # Opening and running through each line of the file of dates
    File.open(@file_path).each do |date|
      
      # Convert the necessary parts of the datetime strings to timestamp and year
      timestamp = Time.parse(date).to_i
      year = Time.parse(date).strftime("%Y");

      # Run the earliest and latest mehtods, to track the earliest and latest years
      earliest(timestamp)
      latest(timestamp)

      # Track how many times each year occurs
      year_arr[year] += 1

    end

    # Find the year with the most entries in the year_arr hash
    largest_year = year_arr.max{|a,b| a[1] <=> b[1]}[0]
    @peak_year = largest_year.to_i
    
  end

  # Find the earliest year
  def earliest (timestamp)
    if @early_year == '' || timestamp < @early_year
      @early_year = timestamp
      @earliest_time = Time.at(timestamp).utc
    end
  end

  # Find the latest year
  def latest (timestamp)
    if @late_year == '' || timestamp > @late_year
      @late_year = timestamp
      @latest_time = Time.at(timestamp).utc
    end
  end

end