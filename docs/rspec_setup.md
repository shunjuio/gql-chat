# RSpec Testing Setup

This project now includes RSpec for testing. Here's how to get started:

## Installation

After adding the RSpec gems to the Gemfile, run:

```bash
bundle install
```

## Running Tests

To run all specs:
```bash
bundle exec rspec
```

To run specific specs:
```bash
# Run model specs only
bundle exec rspec spec/models

# Run a specific spec file
bundle exec rspec spec/models/user_spec.rb

# Run with documentation format
bundle exec rspec --format documentation
```

## RSpec Configuration

- `.rspec`: Contains default RSpec options
- `spec/spec_helper.rb`: General RSpec configuration
- `spec/rails_helper.rb`: Rails-specific RSpec configuration

## Test Structure

- `spec/models/`: Model tests
- `spec/controllers/`: Controller tests  
- `spec/requests/`: Request/integration tests
- `spec/system/`: System/feature tests
- `spec/support/`: Shared test utilities

## Example Usage

The project includes example specs for the User and Message models demonstrating:
- Model validation testing
- RSpec syntax and expectations
- Rails model testing patterns

## Additional Gems

- `rspec-rails`: RSpec integration for Rails
- `factory_bot_rails`: Test data factories (optional, can be added later)