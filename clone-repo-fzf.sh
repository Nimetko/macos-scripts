gh repo list | fzf | awk '{print $1}' | xargs -I {} gh repo clone {}

