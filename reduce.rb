#! /usr/bin/env ruby
# Stephanie Embgen
# this script reduces the clustering of the whole data to the users present in part 1 of the data

require 'set'

def reduce(file1, file2, newfile)
  part1users = Set.new
  
  #write users from file1 to set
  File.open(file1, 'r') do |f1|
    while line = f1.gets
      part1users.add(line.split(';')[0].to_i)
    end
  end
  puts "#{part1users.size} users in part 1"
  
  # open new file to write new cluster data to
  File.open(newfile, 'w') do |nf|
    
    # open original clustering file
    File.open(file2, 'r') do |f2|
      while line = f2.gets
        user = line.split(';')[0].to_i
        if part1users.member? user
          nf.puts line
        end
      end
    end
  end
  puts "clustering reduced and written to #{newfile}"
end

#reduce("testpart1.txt","test.activationPerUser.txt", "reduced.txt")
reduce("cluster_part1.csv", "cluster_all.csv", "cluster_all_reduced.csv")
reduce("cluster_part2.csv", "cluster_all_reduced.csv", "cluster_all_reduced2.csv")