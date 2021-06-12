require "time"

class Challenge
  attr_reader :earliest_time
  attr_reader :latest_time
  attr_reader :peak_year

  def initialize(file_path)
    @file_path = File.expand_path(file_path)
    parse()
  end

  def parse
    # Parse the file located at @file_path and set three attributes:
    #
    # earliest_time: the earliest time contained within the data set
    # latest_time: the latest time contained within the data set
    # peak_year: the year with the most number of timestamps contained within the data set

    date_arr = []
    year_arr = []

    # Opening and running through each line of the file of dates
    File.open(@file_path).each do |date|
      
      # Parsing file and converting necessary parts of the datetime strings
      timestamp = Time.parse(date).to_i
      timezone = Time.parse(date).strftime("%:z")
      year = Time.parse(date).strftime("%Y")

      # Storing the date, timezone offset, and timestamp to an array of hashes
      date_arr.push(:timestamp => timestamp, :timezone => timezone)
      year_arr.push(year)

    end

    # Setting date-related variables for earliest and latest dates
    earliest_date = date_arr.min{|a,b| a[:timestamp] <=> b[:timestamp]}
    earliest_utc = Time.at(earliest_date[:timestamp]).utc
    earliest_tzone = Time.zone_offset(earliest_date[:timezone])

    latest_date = date_arr.max{|a,b| a[:timestamp] <=> b[:timestamp]}
    latest_utc = Time.at(latest_date[:timestamp]).utc
    latest_tzone = Time.zone_offset(latest_date[:timezone])

    # Combining date variables to form the datetime string
    earliest_combined = Time.at(earliest_utc + earliest_tzone).strftime("%Y-%m-%dT%H:%M:%S")
    latest_combined = Time.at(latest_utc + latest_tzone).strftime("%Y-%m-%dT%H:%M:%S")

    # Combining the datetime string with the correct timezone offset
    @earliest_time = earliest_combined + " " + earliest_date[:timezone]
    @latest_time = latest_combined + " " + latest_date[:timezone]

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
