#! /usr/bin/env ruby
# Stephanie Embgen
# This script measures how much activation happened between pairs of users
# if if only one direction of the communication should be included in PerUser, 
# uncomment the two 'unless'-controls


def userPairs(originalfile, newfilePerUser, newfileTotal)
  
  # Hash of Arrays to store users communicated with for each user
  communications = Hash.new{|hash, key| hash[key] = Array.new}
  
  File.open(originalfile, 'r') do |of|
    while line = of.gets 
      user1 = line.split(' ')[0].to_i
      user2 = line.split(' ')[1].to_i
      # add communication to array of each user
      communications[user1] = communications[user1]<<user2 
      communications[user2] = communications[user2]<<user1
    end
    puts "created hash for all users"
  end
  
  users = communications.keys.sort
  
  File.open(newfileTotal, 'w') do |nft|
    File.open(newfilePerUser, 'w') do |nfpu|
      users.each do |user|
        userlist = communications[user]
        # number of communications total for the user is length of array
        nft.puts "#{user} #{userlist.length}"
        userlist.sort!
        i = 0
        thisuser = userlist[0]
        userlist.each do |u|
          # count occurrence of each user
          if thisuser == u
            i += 1
          else
            # if new user is encountered, write old user to file
            # !!! uncomment this if you don't want each pair twice
            unless thisuser < user
              nfpu.puts "#{user} #{thisuser} #{i}"
            end
            i = 1
            thisuser = u
          end
        end
        # write last encountered user to file
        # !!! uncomment this if you don't want each pair twice
        unless thisuser < user
          nfpu.puts "#{user} #{thisuser} #{i}"
        end
      end
    end
  end
  puts "created files #{newfileTotal} and #{newfilePerUser}"
end

#userPairs('test.activation_sorted.txt', 'test.activationPerUser.txt', 'test.activationTotal.txt')
userPairs('blabla.activation_sorted_part1', 'blabla.activationPerUser_part1', 'blabla.activationTotal_part1')
userPairs('blabla.activation_sorted_part2', 'blabla.activationPerUser_part2', 'blabla.activationTotal_part2')