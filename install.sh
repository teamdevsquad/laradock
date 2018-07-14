main() {
  set -e

  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi

  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
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
    echo ''
    printf "${YELLOW}It appears that you already have docker installed for your project.${NORMAL}\n"
    printf "You'll need to remove the folder ./$LARADOCK_FOLDER and the file ./docker-compose.yml you want to continue.\n"
    exit
  fi

  if [ -f "./docker-compose.yml" ]; then
    echo ''
    printf "${YELLOW}It appears that you already have docker installed for your project.${NORMAL}\n"
    printf "You'll need to remove the folder ./$LARADOCK_FOLDER and the file ./docker-compose.yml you want to continue.\n"
    exit
  fi

  umask g-w,o-w

  printf "${BLUE}Cloning DevSquad Laradock...${NORMAL}\n"
  command -v git >/dev/null 2>&1 || {
    echo ''
    printf "${RED}git is not installed.${NORMAL}\n"
    exit 1
  }

  if [ "$OSTYPE" = cygwin ]; then
    if git --version | grep msysgit > /dev/null; then
      echo ''
      printf "${RED}Error: Windows/MSYS Git is not supported on Cygwin.${NORMAL}\n"
      printf "${RED}Error: Make sure the Cygwin git package is installed and is first on the path.${NORMAL}\n"
      exit 1
    fi
  fi

  env git clone --depth=1 https://github.com/teamdevsquad/laradock.git "$LARADOCK_WORKSPACE" || {
    echo ''
    printf "${RED}Error: git clone of teamdevsquad/laradock repo failed${NORMAL}\n"
    exit 1
  }

  mv $LARADOCK_WORKSPACE/docker $LARADOCK_FOLDER
  mv $LARADOCK_WORKSPACE/docker-compose.yml ./docker-compose.yml

  rm -Rf $LARADOCK_WORKSPACE

  printf "${GREEN}"
  echo ''
  echo 'DevSquad Laradock is now installed'
  echo ''
  echo 'Documentation available at https://github.com/teamdevsquad/laradock/wiki.'
  echo ''
  printf "${NORMAL}"
}

main