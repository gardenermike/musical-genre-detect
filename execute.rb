base_directory = "./music"

genres = Dir.entries(base_directory).select {|g| !g.match(/^\./)}.select do |dir|
  File.directory?("#{base_directory}/#{dir}")
end

genres.each_with_index do |genre, index|
  files = Dir.entries("#{base_directory}/#{genre}").select do |path|
    File.file?("#{base_directory}/#{genre}/#{path}") && path.match(/mp3$/)
  end

  files.each do |file|
    path = "#{base_directory}/#{genre}/#{file}"
    puts "about to run #{path}"
    wav_path = "#{path}.wav"
    system "lame","--decode", "-b", "16","-m", "m", path, wav_path
    system "octave", "-q", "transform.m", wav_path, (index + 1).to_s
    #length = `wc -l X.txt`
    #puts "X.txt is now #{length} lines long"
  end
end
