require "debug"
require "./app/retryable"
require "./app/file_reader"
require "./app/file_reader_orig"

def reload
  load "./app/retryable.rb"
  load "./app/file_reader.rb"
  load "./app/file_reader_orig.rb"
end

# def reload
#   Dir.glob('./app/*.rb').each { |file| load file }
# end

puts "FileReader loaded, try it out for example: FileReader.new(\"example.txt\").read_with_retry"
