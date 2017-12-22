puts("Pry history: #{history_file = "~/.pry_history_#{File.basename(Dir.pwd)}"}")
Pry.config.history.file = File.expand_path(history_file)
