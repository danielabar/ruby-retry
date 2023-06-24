class FileReader
  MAX_ATTEMPTS = 2

  def initialize(file_path)
    @file_path = file_path
    @attempt = 0
  end

  def read_with_retry
    File.read(@file_path)
    puts "File read successful!"
  rescue Errno::ENOENT
    handle_file_not_found
  end

  private

  def handle_file_not_found
    puts "File not found."

    @attempt += 1
    if @attempt <= MAX_ATTEMPTS
      puts "Attempt #{@attempt} retrying..."
      read_with_retry
    else
      puts "Max retry attempts of #{MAX_ATTEMPTS} reached."
    end
  end
end
