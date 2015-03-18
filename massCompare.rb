#! /usr/bin/env ruby
# Stephanie Embgen
# This script compares the clustering for the biggest clusters

require 'set'

def massCompare(file1, file2, clustermetric1, clustermetric2, resultfile, n)
  
  # hash to store clusters by id
  clusters1 = Hash.new{|hash, key| hash[key] = Array.new}
  clusters2 = Hash.new{|hash, key| hash[key] = Array.new}
  bigClusters1 = []
  bigClusters2 = []
  
  # read file 1
  File.open(file1, 'r') do |f1|
    while line = f1.gets
      user = line.split(';')[0].to_i 
      cluster = line.split(';')[2].to_i
      clusters1[cluster] = clusters1[cluster]<<user
    end
  end
  
  # read file 2
  File.open(file2, 'r') do |f2|
    while line = f2.gets
      user = line.split(';')[0].to_i 
      cluster = line.split(';')[2].to_i
      clusters2[cluster] = clusters2[cluster]<<user
    end
  end
  
  # read cluster ids from cluster metrics
  File.open(clustermetric1, 'r') do |cm1|
    i = -16
    while i < n && line = cm1.gets
      bigClusters1 << line.split(', ')[0].to_i if i >= 0
      i += 1
    end
  end
  puts bigClusters1
  
  File.open(clustermetric2, 'r') do |cm2|
    i = -16
    while i < n && line = cm2.gets
      bigClusters2 << line.split(', ')[0].to_i if i >= 0
      i += 1
    end
  end
  puts bigClusters2
  
  # open file to start writing results
  File.open(resultfile, 'w') do |rf|
    
    #write sizes of clusters in first row
    bigClusters1.each { |cid| rf.print(";#{clusters1[cid].size}")}
    rf.print(";\n")
    
    #iterate over second array of cluster ids
    bigClusters2.each do |c2|
      rf.print(clusters2[c2].size)
      bigClusters1.each do |c1|
        rf.print(';')
        commonGround = clusters2[c2] & clusters1[c1]
        rf.print(commonGround.size)
      end
      rf.print(";\n")
    end
  end

end

#massCompare("cluster2.txt", "cluster1.txt", "cluster2.txt", "result.txt")
massCompare("cluster_all_reduced.csv", "cluster_part1.csv", "clustermetric_all.txt", "clustermetric_part1.txt", "cluster_comparison.csv", 50)
