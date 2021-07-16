# Based on https://github.com/conda/conda/issues/7855#issuecomment-456085432
# This forces to conda's to setup everytime.
if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
  . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
else
  export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
fi
