require "time"

class Challenge
  attr_reader :earliest_time
  attr_reader :latest_time
  attr_reader :peak_year

  def initialize(file_path)
    @file_path = File.expand_path(file_path)
    @later_date = ''
    @earlier_date = ''
    @year_arr = Hash.new(0)
    parse()
  end

  def parse
    # Parse the file located at @file_path and set three attributes:
    #
    # earliest_time: the earliest time contained within the data set
    # latest_time: the latest time contained within the data set
    # peak_year: the year with the most number of timestamps contained within the data set

    # Opening and running through each line of the file of dates
    File.open(@file_path).each do |date|
      
      # Convert the necessary parts of the datetime strings to timestamp and year
      curr_date = Time.strptime(date, "%Y-%m-%dT%H:%M:%S%z")
      timestamp = curr_date.to_i
      year = curr_date.year

      # Run methods to track the earliest date, latest date, and peak year
      earliest_date(timestamp)
      latest_date(timestamp)
      track_year(year)

    end

    # Find the year with the most entries in the year_arr hash created in track_year()
    common_year = @year_arr.max{|a,b| a[1] <=> b[1]}

    # Assign the dates created in methods to their applicable variables
    @peak_year = common_year[0].to_i
    @earliest_time = Time.at(@earlier_date)
    @latest_time = Time.at(@later_date)
    
  end

  # Find the earliest year by comparing the current timestamp to the previous earliest timestamp
  def earliest_date (timestamp)
    if @earlier_date == '' || timestamp < @earlier_date
      @earlier_date = timestamp
    end
  end

  # Find the latest year by comparing the current timestamp to the previous latest timestamp
  def latest_date (timestamp)
    if @later_date == '' || timestamp > @later_date
      @later_date = timestamp
    end
  end

  # Track how many times each year occurs
  def track_year (year)
    @year_arr[year] += 1
  end

end