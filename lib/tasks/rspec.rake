namespace :spec do
  desc "Setup RSpec for the application"
  task setup: :environment do
    puts "RSpec has been configured for this application!"
    puts ""
    puts "To get started:"
    puts "1. Run 'bundle install' to install RSpec gems"
    puts "2. Run 'bundle exec rspec' to run all specs"
    puts "3. Run 'bundle exec rspec spec/models' to run model specs only"
    puts ""
    puts "Configuration files:"
    puts "- .rspec (RSpec options)"
    puts "- spec/spec_helper.rb (general configuration)"  
    puts "- spec/rails_helper.rb (Rails-specific configuration)"
    puts ""
    puts "Example specs are available in:"
    puts "- spec/models/user_spec.rb"
    puts "- spec/models/message_spec.rb"
  end

  desc "Generate a new model spec"
  task :generate_model, [:model_name] => :environment do |t, args|
    model_name = args[:model_name]
    if model_name.nil?
      puts "Usage: rake spec:generate_model[ModelName]"
      exit 1
    end

    spec_content = <<~RUBY
      require 'rails_helper'

      RSpec.describe #{model_name}, type: :model do
        describe "validations" do
          # Add your validation tests here
          pending "add some examples to (or delete) \#{__FILE__}"
        end

        describe "associations" do
          # Add your association tests here  
          pending "add some examples to (or delete) \#{__FILE__}"
        end

        describe "methods" do
          # Add your method tests here
          pending "add some examples to (or delete) \#{__FILE__}"
        end
      end
    RUBY

    filename = "spec/models/#{model_name.downcase}_spec.rb"
    File.write(filename, spec_content)
    puts "Generated #{filename}"
  end
end