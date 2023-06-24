require "debug"
require "./app/retryable"
require "./app/file_reader"

def reload
  load "./app/retryable.rb"
  load "./app/file_reader.rb"
end

puts "FileReader loaded, try it out for example: FileReader.new(\"example.txt\").read_with_retry"
