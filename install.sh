main() {
  set -e

  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi

  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  if [ ! -n "$LARADOCK_WORKSPACE" ]; then
    LARADOCK_WORKSPACE=./.laradock
  fi

  if [ -d "$LARADOCK_WORKSPACE" ]; then
    rm -Rf $LARADOCK_WORKSPACE
  fi

  if [ ! -n "$LARADOCK_FOLDER" ]; then
    LARADOCK_FOLDER=docker
  fi

  if [ -d "./$LARADOCK_FOLDER" ]; then
    printf "${YELLOW}It appears that you already have docker installed for your project.${NORMAL}\n"
    printf "You'll need to remove the folder ./$LARADOCK_FOLDER and the file ./docker-compose.yml you want to continue.\n"
    exit
  fi

  if [ -f "./docker-compose.yml" ]; then
    printf "${YELLOW}It appears that you already have docker installed for your project.${NORMAL}\n"
    printf "You'll need to remove the folder ./$LARADOCK_FOLDER and the file ./docker-compose.yml you want to continue.\n"
    exit
  fi

  umask g-w,o-w

  printf "${BLUE}Cloning DevSquad Laradock...${NORMAL}\n"
  command -v git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    exit 1
  }

  if [ "$OSTYPE" = cygwin ]; then
    if git --version | grep msysgit > /dev/null; then
      echo "Error: Windows/MSYS Git is not supported on Cygwin"
      echo "Error: Make sure the Cygwin git package is installed and is first on the path"
      exit 1
    fi
  fi

  env git clone --depth=1 https://github.com/teamdevsquad/laradock.git "$LARADOCK_WORKSPACE" || {
    printf "Error: git clone of teamdevsquad/laradock repo failed\n"
    exit 1
  }

  printf "${GREEN}"
  echo 'p.s. Documentation available at https://github.com/teamdevsquad/laradock/wiki.'
  echo ''
  printf "${NORMAL}"
}

main