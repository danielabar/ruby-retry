require "active_support/all"
require "timeout"

module Retryable
  # Retries the execution of a block of code with retry logic.
  #
  # @param [Array<Exception>] args The list of exceptions that should trigger a retry.
  # @param [Hash] options The options for retrying the code block.
  # @option options [Integer] :limit (3) The maximum number of retry attempts after initial run.
  # @option options [Integer] :timeout_in The maximum time in seconds to wait for each retry attempt.
  # @yield The block of code to be executed.
  #
  # @example Retry the code block with a specific exception and a custom limit:
  #   Retryable.with_retries(Errno::ENOENT, limit: 5) do
  #     # Code to be retried if Errno::ENOENT is raised
  #   end
  #
  # @example Retry the code block with default exceptions and a timeout:
  #   Retryable.with_retries(limit: 3, timeout_in: 10) do
  #     # Code to be retried if StandardError or Timeout::Error is raised,
  #     # with a maximum of 3 retries and a timeout of 10 seconds.
  #   end
  #
  # @example Retry the code block with default options:
  #   Retryable.with_retries do
  #     # Code to be retried if StandardError or Timeout::Error is raised,
  #     # with a maximum of 3 retries and no timeout.
  #   end
  #
  # @example Retry the code block with multiple exceptions:
  #   Retryable.with_retries(Errno::ECONNRESET, Errno::ETIMEDOUT, limit: 5) do
  #     # Code to be retried if Errno::ECONNRESET or Errno::ETIMEDOUT is raised,
  #     # with a maximum of 5 retries and no timeout.
  #   end
  #
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  extend self

  def with_retries(*args)
    options = args.extract_options!
    exceptions = args

    options[:limit] ||= 3

    # Default exceptions to handle if caller has not provided any
    exceptions = [StandardError, Timeout::Error] if exceptions.empty?

    retried = 0
    begin
      if options[:timeout_in]
        Timeout.timeout(options[:timeout_in]) do
          return yield
        end
      else
        yield
      end
    rescue *exceptions => e
      if retried >= options[:limit]
        puts "Retryable failed after #{options[:limit]} retry(ies), exception: #{e}"
        raise e
      end

      retried += 1
      puts "Retryable retrying (attempt #{retried} of #{options[:limit]})"
      retry
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
end
