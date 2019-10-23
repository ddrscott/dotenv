desc 'do everything'
task install: %i(links pips)

desc 'install all Python packages'
task :pips do
  %w(Pygments).each do |pkg|
    system("pip2 install #{pkg}")
    system("pip3 install #{pkg}")
  end
end

desc 'symlink files'
task :links do
  ln_sf File.expand_path('.'), File.expand_path('~/ddrscott')
  ln_sf File.expand_path('zsh/.zshrc'), File.expand_path('~/.zshrc')
  ln_sf File.expand_path('tmux.conf'), File.expand_path('~/.tmux.conf')
  ln_sf File.expand_path('ag/.agignore'), File.expand_path('~/.agignore')
  ln_sf File.expand_path('screen/.screenrc'), File.expand_path('~/.screenrc')
  ln_sf File.expand_path('pry/pryrc.rb'), File.expand_path('~/.pryrc')
  ln_sf File.expand_path('zsh/themes/ddrscott.zsh-theme'), File.expand_path('~/.oh-my-zsh/themes/ddrscott.zsh-theme')

  mkdir_p File.expand_path('~/.ptpython')
  ln_sf File.expand_path('ptpython/config.py'), File.expand_path('~/.ptpython/config.py')
end
