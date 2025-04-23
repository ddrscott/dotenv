if [ -d /opt/homebrew/bin ]; then
  ruby_script="$(brew --prefix)/opt/chruby/share/chruby/chruby.sh"
  if [ -f $ruby_script ] ; then
    source $ruby_script
  fi
fi
