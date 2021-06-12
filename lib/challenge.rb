require "time"

class Challenge
  attr_reader :earliest_time
  attr_reader :latest_time
  attr_reader :peak_year

  def initialize(file_path)
    @file_path = File.expand_path(file_path)
    @late_year = ''
    @early_year = ''
    parse()
  end

  def parse
    # Parse the file located at @file_path and set three attributes:
    #
    # earliest_time: the earliest time contained within the data set
    # latest_time: the latest time contained within the data set
    # peak_year: the year with the most number of timestamps contained within the data set

    # Initialize local variables
    year_arr = Hash.new(0)

    # Opening and running through each line of the file of dates
    File.open(@file_path).each do |date|
      
      # Convert the necessary parts of the datetime strings to timestamp and year
      curr_date = Time.parse(date)
      timestamp = curr_date.to_i
      years = curr_date.year;

      # Run the earliest_date and latest_date mehtods, to track the earliest and latest dates
      earliest_date(timestamp)
      latest_date(timestamp)

      # Track how many times each year occurs
      year_arr[years] += 1

    end

    # Find the year with the most entries in the year_arr hash
    common_year = year_arr.max{|a,b| a[1] <=> b[1]}

    # Converting and setting the peak_year, earliest_time, latest_tiem variables
    @peak_year = common_year[0].to_i
    @earliest_time = Time.at(@early_year).utc
    @latest_time = Time.at(@late_year).utc
    
  end

  # Find the earliest year by comparing the current timestamp to the previous earliest timestamp
  def earliest_date (timestamp)
    if @early_year == '' || timestamp < @early_year
      @early_year = timestamp
    end
  end

  # Find the latest year by comparing the current timestamp to the previous latest timestamp
  def latest_date (timestamp)
    if @late_year == '' || timestamp > @late_year
      @late_year = timestamp
    end
  end

end