## Retryable

**Module**: Retryable

The `Retryable` module provides a `with_retries` method that allows for executing a block of code with retry logic.

### Usage

To use the `with_retries` method, provide a list of exceptions to be handled as the first argument, followed by an optional hash of options.

```ruby
Retryable.with_retries(Errno::ENOENT, limit: 3) do
  # Code to be retried
end
```

### Method Signature

```ruby
def self.with_retries(*args)
```

### Parameters

- `args` (list of exceptions) - The list of exceptions that should trigger a retry. These exceptions can be specified individually or as an array. If no exceptions are provided, `StandardError` and `Timeout::Error` are used as default retry triggers.

### Options

- `limit` (integer, default: 3) - The maximum number of retry attempts.
- `timeout_in` (integer) - The maximum time in seconds to wait for each retry attempt. If specified, the code block will be executed within a timeout.

### Block Syntax

The `with_retries` method expects a block of code to be executed. The code within the block will be retried in case of exceptions as per the provided options.

### Retry Logic

The `with_retries` method executes the code block and captures any exceptions specified in the `args` parameter. If an exception is caught, the method will retry the code block until the maximum retry limit is reached.

If a `timeout_in` option is provided, the code block will be executed within a timeout, and if the timeout is exceeded, a `Timeout::Error` exception will be raised and retried if it is included in the list of exceptions.

### Exception Handling

When an exception specified in the `args` parameter is encountered during execution of the code block, the method will retry the block until the maximum retry limit is reached or an exception not in the `args` list is raised.

If the maximum retry limit is exceeded, the method will output a message indicating retry failure (output text is yet to be determined) and re-raise the last encountered exception.

### Examples

1. Retry the code block with a specific exception and a custom limit:

```ruby
Retryable.with_retries(Errno::ENOENT, limit: 5) do
  # Code to be retried if Errno::ENOENT is raised
end
```

2. Retry the code block with default exceptions and a timeout:

```ruby
Retryable.with_retries(limit: 3, timeout_in: 10) do
  # Code to be retried if StandardError or Timeout::Error is raised,
  # with a maximum of 3 retries and a timeout of 10 seconds.
end
```

3. Retry the code block with default options:

```ruby
Retryable.with_retries do
  # Code to be retried if StandardError or Timeout::Error is raised,
  # with a maximum of 3 retries and no timeout.
end
```

4. Retry the code block with multiple exceptions:

```ruby
Retryable.with_retries(Errno::ECONNRESET, Errno::ETIMEDOUT, limit: 5) do
  # Code to be retried if Errno::ECONNRESET or Errno::ETIMEDOUT is raised,
  # with a maximum of 5 retries and no timeout.
end
```

**Note**: The output text for retry failure is yet to be determined and needs to be implemented.
