#! /usr/bin/env ruby
# Stephanie Embgen
# This script calculates inter- and intra-cluster edges

def countEdges(clusterfile, interactionfile)
  
  interedges = 0
  intraedges = 0
  
  # hash to store cluster ids for users
  users = Hash.new

  # read clusterfile
  File.open(clusterfile, 'r') do |cf|
    while line = cf.gets
      user = line.split(';')[0].to_i 
      cluster = line.split(';')[2].to_i
      users[user] = cluster
    end
  end
  
  # read interactionfile
  File.open(interactionfile, 'r') do |iaf|
    while line = iaf.gets
      user1 = line.split(' ')[0].to_i
      user2 = line.split(' ')[1].to_i
      weight = line.split(' ')[2].to_i
      if users[user1] && users[user2]
        users[user1] == users[user2] ? intraedges += weight : interedges += weight
      end
    end
  end
  
  puts "#{interedges} inter-cluster edges"
  puts "#{intraedges} intra-cluster edges"
  puts "Coverage: #{100*intraedges/(interedges+intraedges)}%"
  
end

puts "whole data"
countEdges('cluster_all.csv', 'blabla.activationPerUser')

puts "whole data reduced"
countEdges('cluster_all_reduced.csv', 'blabla.activationPerUser_part1')

puts "part 1"
countEdges('cluster_part1.csv', 'blabla.activationPerUser_part1')

puts "part 2"
countEdges('cluster_part2.csv', 'blabla.activationPerUser_part2')
    