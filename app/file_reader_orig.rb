class FileReaderOrig
  MAX_ATTEMPTS = 2

  def initialize(file_path)
    @file_path = file_path
    @attempt = 0
  end

  def read_with_retry
    File.read(@file_path)
    puts "File read successful!"
  rescue Errno::ENOENT
    if @attempt < MAX_ATTEMPTS
      @attempt += 1
      puts "File not found. Retrying (attempt #{@attempt} of #{MAX_ATTEMPTS})..."
      retry
    else
      puts "File not found after #{MAX_ATTEMPTS} attempts."
    end
  end
end
