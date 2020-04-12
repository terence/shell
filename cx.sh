# Shell script to deploy file to env.


# MacOS Deploy
# Git Bash on Windows deplot
# Linux Debian deploy
# Redhat deploy


# Step #1 : 
read -p "Are you sure? (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
  echo "Yes selected"
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi
