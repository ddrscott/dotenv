function conda() {
  cat <<'EOF'
We don't use conda anymore.
Please use `uv` instead!

Try:

   uv venv --python 3.13

   uv pip install -r requirements.txt

   uv pip install -e .

   uv pip compile requirements.in --output-file requirements.txt

   uv run main.py

Note:
Some .env files may call `conda activate`.
`.venv/bin/activate` is automatically sourced by `zsh/custom/z900-uv-env.sh`
EOF
}
