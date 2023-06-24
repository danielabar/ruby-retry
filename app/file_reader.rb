# require "app/retryable"

class FileReader
  include Retryable

  def initialize(file_path)
    @file_path = file_path
  end

  def experiment(*args)
    # extract the last hash
    options = args.extract_options!
    # everything that's left
    exceptions = args
    puts "=== options: #{options}, exceptions: #{exceptions}"
  end

  def read_with_retry
    Retryable.with_retries(Errno::ENOENT, limit: 1, timeout_in: 2) do
      File.read(@file_path)
      puts "File read successful!"
    end
  end
end
