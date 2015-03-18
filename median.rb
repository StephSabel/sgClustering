#! /usr/bin/env ruby
# Stephanie Embgen
# This script seperates a file with twitter interaction data (sorted by timestamp) 
# into two files by the median timestamp

def findmedian(filename)
  timestamps = []
  File.open(filename, 'r') do |f|
    while line = f.gets
      timestamps<<line.split(' ')[2].to_i
    end
  end
  return timestamps.length.odd? ? timestamps[(timestamps.length - 1)/2] : timestamps[timestamps.length/2 - 1]
end


def seperate_files(originalfile, newfile1, newfile2)
  median = findmedian(originalfile)
  puts "Median Timestamp is #{median}"
  medianflag = true
  File.open(originalfile, 'r') do |of|
    File.open(newfile1, 'w') do |nf1|
      while medianflag && line = of.gets 
        nf1.puts line
        medianflag = (line.split(' ')[2].to_i < median)
      end
    end
    puts "First half of data written to #{newfile1}"
    File.open(newfile2, 'w') do |nf2|
      while line = of.gets
        nf2.puts line
      end
    end
    puts "Second half of data written to #{newfile2}"
  end
end


seperate_files('blabla.activation_sorted', 'blabla.activation_sorted_part1.txt', 'blabla.activation_sorted_part2.txt')