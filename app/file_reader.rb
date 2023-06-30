require "./app/retryable"

class FileReader
  include Retryable

  def initialize(file_path)
    @file_path = file_path
  end

  # Experiment to understand `*args` and
  # ActiveSupport `extract_options!` method.
  def experiment(*args)
    # extract the last hash
    options = args.extract_options!
    # everything that's left
    exceptions = args
    puts "=== options: #{options}, exceptions: #{exceptions}"
  end

  def read_simple
    File.read(@file_path)
    puts "File read successful"
  rescue Errno::ENOENT => e
    puts "File read failed, exception: #{e}"
  end

  def read_slow
    with_retries(timeout_in: 2) do
      sleep(3)
      File.read(@file_path)
      puts "File read successful!"
    end
  end

  def read_file
    with_retries(Errno::ENOENT, limit: 2, timeout_in: 2) do
      File.read(@file_path)
      puts "File read successful!"
    end
  end
end
