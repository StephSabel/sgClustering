#! /usr/bin/env ruby
# Stephanie Embgen
# This script compares the clustering for some specific users
# Users with highest activity: 
# 32075 105119490
# 23275 84279963
# 21472 140118545
# 20986 105296218
# 19564 58528137

def compareClusters(user, file1, file2)
  
  cluster1 = []
  cluster2 = []
  cluster1id = 0
  cluster2id = 0
  
  #find user in file 1
  File.open(file1, 'r') do |f1|
    while line = f1.gets
      if line.split(';')[0].to_i == user
        cluster1id = line.split(';')[2].to_i
      end
    end
  end
  
  #find user in file 2
  File.open(file2, 'r') do |f2|
    while line = f2.gets
      if line.split(';')[0].to_i == user
        cluster2id = line.split(';')[2].to_i
        puts "#{line.split(';')[1]} (#{user})"
      end
    end
  end
  
  #find whole cluster in file 1
  File.open(file1, 'r') do |f1|
    while line = f1.gets
      if line.split(';')[2].to_i == cluster1id
        cluster1<<line.split(';')[0].to_i
      end
    end
  end
  
  #find whole cluster in file 2
  File.open(file2, 'r') do |f2|
    while line = f2.gets
      if line.split(';')[2].to_i == cluster2id
        cluster2<<line.split(';')[0].to_i
      end
    end
  end
  
  #compare the 2 clusters
  puts "#{cluster1.size} users in #{cluster1id}"
  puts "#{cluster2.size} users in #{cluster2id}"
  
  commonGround = cluster1 & cluster2
  puts "The clusters overlap by #{100*commonGround.size/cluster1.size}% / #{100*commonGround.size/cluster2.size}%"
end

#compareClusters(3, "cluster1.txt", "cluster2.txt")
compareClusters(105119490, "cluster_all_reduced.csv", "cluster_part1.csv")
compareClusters(140118545, "cluster_all_reduced.csv", "cluster_part1.csv")
compareClusters(58528137, "cluster_all_reduced.csv", "cluster_part1.csv")
compareClusters(158314798, "cluster_all_reduced.csv", "cluster_part1.csv")
compareClusters(355741893, "cluster_all_reduced.csv", "cluster_part1.csv")
compareClusters(397400299, "cluster_all_reduced.csv", "cluster_part1.csv")
compareClusters(53732896, "cluster_all_reduced.csv", "cluster_part1.csv")
compareClusters(209708391, "cluster_all_reduced.csv", "cluster_part1.csv")
compareClusters(155927976, "cluster_all_reduced.csv", "cluster_part1.csv")
compareClusters(30673492, "cluster_all_reduced.csv", "cluster_part1.csv")
compareClusters(52422878, "cluster_all_reduced.csv", "cluster_part1.csv")
compareClusters(14955353, "cluster_all_reduced.csv", "cluster_part1.csv")
compareClusters(26257166, "cluster_all_reduced.csv", "cluster_part1.csv")
compareClusters(19923144, "cluster_all_reduced.csv", "cluster_part1.csv")
  