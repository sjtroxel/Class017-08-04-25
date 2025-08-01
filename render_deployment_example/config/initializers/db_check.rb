begin
  ActiveRecord::Base.establish_connection
  ActiveRecord::Base.connection
  puts "=== DEBUG: DB CONNECTION OK ==="
rescue => e
  puts "=== DEBUG: DB CONNECTION FAILED: #{e.message} ==="
end