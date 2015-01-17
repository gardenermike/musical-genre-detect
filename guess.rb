require 'open3'
require 'pathname'

base_directory = Pathname.new('music')
genres = Dir.entries('music').select {|item| (base_directory + item).directory?}

filename = ARGV[0]
#convert file to wav
wav_filename = filename + '.wav'


Open3.popen3("lame","--decode", "-b", "16","-m", "m", filename, wav_filename) do |stdin, stdout, stderr, wait_thr|
  puts stderr.gets(nil)
  puts stdout.gets(nil)
end
puts "Done transcoding"

Open3.popen3('octave', '-q', 'guess.m', wav_filename) do |stdin, stdout, stderr, wait_thr|

  genre_id = stdout.gets

  genre_id = genre_id.strip.to_i

  genre = genres[genre_id - 1]

  puts "I guess... #{genre}!"

end
