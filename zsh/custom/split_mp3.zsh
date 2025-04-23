function split_mp3() {
  if [[ $# -ne 2 ]]; then
    echo "Usage: splitmp3 <src> <dst>"
    return 1
  fi

  local src_file=$1
  local dst_file=$2

  curl -v -X 'POST' 'https://karaoke.dataturd.com/mp3/' \
       -H 'accept: application/json' \
       -H 'Content-Type: multipart/form-data' \
       -F "file=@${src_file};type=audio/x-ogg" \
       -o "${dst_file}"
}
