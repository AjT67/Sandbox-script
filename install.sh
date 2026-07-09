USERNAME="AjT67"
REPONAME="Sandbox-script"
NAME="Aj"
USEREMAIL="14828@holbertonstudents.com"
REPOS=("git-intro" "holbertonschool-shell" "holbertonschool-low_level_programming");

# Get the bashrc from git repo and save to .bashrc 
echo "hello, getting bashrc and saving your old one";
	if [[ -f ~/.bashrc ]]; then
		mv $HOME/.bashrc $HOME/.bashrc.bak;
	fi
wget -qO ~/.bashrc https://raw.githubusercontent.com/$USERNAME/$REPONAME/refs/heads/main/bashrc

# Get the bash_aliases from git repo and save to .bash_aliases 
echo "hello, getting bash_aliases and saving your old one";
	if [[ -f ~/.bash_aliases ]]; then
		mv $HOME/.bash_aliases $HOME/.bash_aliases.bak;
	fi
wget -qO ~/.bash_aliases https://raw.githubusercontent.com/$USERNAME/$REPONAME/refs/heads/main/bash_aliases


git config --global user.email "$USEREMAIL";
git config --global user.name "$NAME";
git config --global credential.helper 'cache --timeout=7200';

echo "and downloading your repos";
for r in "${REPOS[@]}"; do
	if [ ! -d "$HOME/$r" ]; then
		git clone "https://github.com/$USERNAME/$r.git $HOME";
	fi
done;

# USER Input repos
GrabRepo()
{
  read -p "Please enter your repo :" REPO;
  if [ ! -d "$HOME/$REPO" ]; then
    git clone "https://github.com/$USERNAME/$REPO.git";
  fi
}

rmdf()
{
		DF=("empty_directory" "my_school" "not_here" "old_school" "ready_to_be_removed" "school");
		echo "Would you like to remove the defualt folders and files from the holberton sandbox";
		echo "${DF[*]}";
		read -p $'y/n: ' -r remove;
		if [[ "$remove" == "y" ]];then
			echo "removing defualts!";
			for d in "${DF[@]}"; do
				if [[ -d "$HOME/$d" || -f "$HOME/$d" ]]; then
					rm -r "~$d";
				fi;
			done		
		else
			echo "righty-o, not removing";
		fi
}

rmdf
source ~/.bashrc;
