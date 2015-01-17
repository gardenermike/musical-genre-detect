require 'open3'
require 'pathname'

base_directory = Pathname.new('music')
genres = Dir.entries('music').select {|item| (base_directory + item).directory?}

filename = ARGV[0]

Open3.popen3('octave', '-q', 'guess.m', filename) do |stdin, stdout, stderr, wait_thr|

  genre_id = stdout.gets

  genre_id = genre_id.strip.to_i

  genre = genres[genre_id - 1]

  puts "I guess... #{genre}!"

end
