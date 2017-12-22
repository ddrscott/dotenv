local_pry_history = File.join(Dir.pwd, '.pry_history')
if File.file? local_pry_history
  puts("\e[33mUsing local Pry history:\e[0m #{local_pry_history}")
  Pry.config.history.file = local_pry_history
end

# Setting max with to handle UUIDs
begin
  require 'table_print'
  tp.set :max_width, 40
rescue LoadError
  puts 'table_print not available'
end
