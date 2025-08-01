puts "=== DEBUG: RAILS_MASTER_KEY present? #{!ENV['RAILS_MASTER_KEY'].nil?} ==="

# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
