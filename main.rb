require 'date'

p DateTime.now.to_s

dirname = File.basename(Dir.getwd)

p dirname

folders = Dir.glob('*').select {|f| File.directory? f}

p folders.to_a
