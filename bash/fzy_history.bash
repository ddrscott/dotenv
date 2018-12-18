#  Bind this command in Bash:
#     bind '"\C-r": " \C-e\C-u\C-y\ey\C-u`__fzy_history__`\e\C-e\er\e^"'
__fzy_history__() (
# 1. output history without timestamps
# 2. reverse the entries so most recent commands are first
# 3. use `fzy` to handle user selection. Use up 1/3rd the display lines.
# 4. string the leading digits from the selection
HISTTIMEFORMAT='' history   \
  | tac                     \
  | fzy -l $((LINES / 3))   \
  | sed 's/^ *\([0-9]*\)\** *//';

)

bind '"\C-r": " \C-e\C-u\C-y\ey\C-u`__fzy_history__`\e\C-e\er\e^"'
