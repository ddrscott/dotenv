# Define the path to the virtual environment activation script
VENV_ACTIVATE_PATH=".venv/bin/activate"

# Function to activate the virtual environment if it exists
activate_venv() {
    if [ -f "$VENV_ACTIVATE_PATH" ]; then
        source "${VENV_ACTIVATE_PATH}"
        echo "Activated: $VENV_ACTIVATE_PATH"
    fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd activate_venv

activate_venv
