desc 'do everything'
task install: %i(links pips)

desc 'install all Python packages'
task :pips do
  %w(Pygments).each do |pkg|
    system("pip install #{pkg}")
  end
end

desc 'symlink files'
task :links do
  ln_sf File.expand_path('ag/.agignore'), File.expand_path('~/.agignore')
end
