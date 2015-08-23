#!/usr/bin/ruby -w
require 'csv'


csv_fname = "/home/sradhu/BRM/2015/FEB/cm06FEB2015bhav.csv"

search_criteria = ['TCS','RELIANCE','ONGC','INFY','IOB','ITC','NTPC']

options = { :headers    => :first_row,
           :converters => [ :all ] }
# we'll save the matches here
matches = nil

# save a copy of the headers
headers = nil
fil=File.open('/home/sradhu/BRM/log.txt',"a")

CSV.open(csv_fname, "r", options ) do |csv|
#csv=CSV.read(csv_fname)
  # Since CSV includes Enumerable we can use 'find_all'
  # which will return all the elements of the Enumerble for 
  # which the block returns true
  matches = csv.find_all do |row|
    match = true
    search_criteria.each do |key|
      match = match && ( row['SYMBOL'] == key )
    end
    match
  end

  headers = csv.headers
end
fil.puts headers
fil.puts matches


