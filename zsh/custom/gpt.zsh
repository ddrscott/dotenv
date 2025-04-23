function gpt-recent() {
  echo "Given these files:"
  find . -type f \
    -mtime -1h \
    \( -name '*.py' -o -name '*.html' -o -name '*.js*' -o -name '*.ts*' \) \
    -exec sh -c 'echo "\n# \`cat -n {}\`"; echo "\`\`\`"; cat -n {}; echo "\`\`\`\n";' \;
  echo "${*}"
}


function fence() {
  echo "Help me with the following files:"
  for file in "$@"; do
    if [ -f "$file" ]; then
      echo -e "
File: \`$(basename "$file")\`:
\`\`\`
$(cat "$file")
\`\`\`
"
    fi
  done
}

function fence() {
  echo <<'EOF'
<system>
Act as a 100x developer helping with a NextJS + Tailwind + DaisyUI project.

**Strict Rules**
- all file output must be complete.
- wrap output with `[FILE path]...[/FILE]` tags and triple-tick fences.
- The output will be piped into another program to automatically adjust all files. Strict coherence to the format is paramount!

**Example Output**
[FILE path/to/code.py]
```python
puts "hello world"
```
[/FILE]

**Notes**
It is okay to explain things, but keep it brief and to the point!
</system>

# Project Files
EOF
  for file in "$@"; do
    if [ -f "$file" ]; then
      echo -e "
[FILE $(basename "$file")]
\`\`\`
$(cat "$file")
\`\`\`
[/FILE]

# Request
"
    fi
  done
}
