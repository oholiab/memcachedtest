#!/usr/bin/env ruby

require 'rubygems'
require 'dalli'

cache = Dalli::Client.new('localhost:11211')

# You can stop after a while or you can USE ALL OF THE MEMORIES.
index = (1..10000000)

word = 'bloop' # This said something much more mature before.
midword = 'a' * (1 * 1024)
longword = 'a' * (1000 * 1024)

$wordarray = [word, midword, longword]
$wordcount = [0,0,0]

# In theory spits out different items to cache at different frequencies
def randword
  num = (rand + rand/2 + rand/4 + rand/8 + rand/8 + rand/8).to_i
  $wordcount[num] += 1
  return $wordarray[num]
end

# 4 threads to write data
set_threads = Hash.new
['a','b','c','d'].each do |thread|
  set_threads[thread] = Thread.new {
    index.each do |i|
      cache.set thread + i.to_s, randword
    end
  }
end

# 4 threads to read data
get_threads = Hash.new
['a','b','c','d'].each do |thread|
  get_threads[thread] = Thread.new {
    index.each do |i|
      cache.set thread + i.to_s, randword
    end
  }
end

# 1 thread to keep an eye on how many of each word has been used
monitor = Thread.new {
  while true
    sleep 5
    puts $wordcount.inspect
  end
}

# join to block on the last joined thread
get_threads['d'].join
monitor.join
