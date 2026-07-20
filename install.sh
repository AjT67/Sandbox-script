#!/usr/bin/env bash
set -euo pipefail

USERNAME="AjT67"
REPONAME="Sandbox-script"
NAME="Aj"
USEREMAIL="14828@holbertonstudents.com"
REPOS=("git-intro" "holbertonschool-shell" "holbertonschool-low_level_programming")

fetch_dotfile()
{
    local remote_name="$1"
    local local_path="$HOME/.$remote_name"

    echo "hello, getting $remote_name and saving your old one"
    if [[ -f "$local_path" ]]; then
        mv "$local_path" "$local_path.bak"
    fi
    if ! wget -qO "$local_path" \
        "https://raw.githubusercontent.com/$USERNAME/$REPONAME/refs/heads/main/$remote_name"; then
        echo "warning: failed to download $remote_name" >&2
    fi
}

fetch_dotfile "bashrc"
fetch_dotfile "bash_aliases"

git config --global user.email "$USEREMAIL"
git config --global user.name "$NAME"
git config --global credential.helper 'cache --timeout=7200'

echo "and downloading your repos"
cd "$HOME"
for r in "${REPOS[@]}"; do
    if [ ! -d "$HOME/$r" ]; then
        git clone "https://github.com/$USERNAME/$r.git"
    fi
done

# USER input repo
grab_repo()
{
    read -rp "Please enter your repo: " repo
    if [ ! -d "$HOME/$repo" ]; then
        git clone "https://github.com/$USERNAME/$repo.git"
    fi
}

rmdf()
{
    local defaults=("empty_directory" "my_school" "not_here" "old_school" "ready_to_be_removed" "school")

    echo "Would you like to remove the default folders and files from the holberton sandbox?"
    echo "${defaults[*]}"
    read -rp "y/n: " remove
    case "$remove" in
        y|Y|yes|Yes)
            echo "removing defaults!"
            for d in "${defaults[@]}"; do
                if [[ -d "$HOME/$d" || -f "$HOME/$d" ]]; then
                    rm -r "$HOME/$d"
                fi
            done
            ;;
        *)
            echo "righty-o, not removing"
            ;;
    esac
}

rmdf
grab_repo

echo "Done. Run 'source ~/.bashrc'"
