# Ruby Retry

A companion project for a blog post about retry in Ruby. This is a plain Ruby project, not Rails.

## Setup

```
bundle install
```

## Usage

Run an irb console with the application code loaded:

```
make console
```

Try it:

```ruby
FileReader.new("example.txt").read_with_retry
# successful

FileReader.new("no-such-file.txt").read_with_retry
# multiple attempts, then fails
```

## TODO

* Tests!
* Deal with method length in Retryable module.
* Use [Ruby Logger](https://blog.appsignal.com/2023/05/17/manage-your-ruby-logs-like-a-pro.html) instead of puts.
