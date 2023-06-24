console:
	irb -r ./boot.rb

lint:
	bundle exec rubocop

test:
	bundle exec rspec
