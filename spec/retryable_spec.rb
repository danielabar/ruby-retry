require "./app/retryable"

RSpec.describe Retryable do
  describe ".with_retries" do
    it "executes the code block without retrying if no exception is raised" do
      expect { described_class.with_retries { puts "Executing code" } }.to output("Executing code\n").to_stdout
    end

    it "retries the code block if a specified exception is raised" do
      counter = 0
      described_class.with_retries(ZeroDivisionError, limit: 4) do
        counter += 1
        raise ZeroDivisionError if counter < 4
      end

      expect(counter).to eq(4)
    end

    it "raises an exception if the retry limit is exceeded" do
      expect do
        described_class.with_retries(ZeroDivisionError, limit: 3) do
          raise ZeroDivisionError
        end
      end.to raise_error(ZeroDivisionError)
    end

    it "retries the code block with default options if no arguments are provided" do
      counter = 0
      described_class.with_retries do
        counter += 1
        raise StandardError if counter < 3
      end

      expect(counter).to eq(3)
    end

    it "retries the code block with a timeout if timeout_in option is provided" do
      counter = 0
      described_class.with_retries(timeout_in: 1) do
        counter += 1
        sleep(2) if counter < 3
      end

      expect(counter).to eq(3)
    end
  end
end
