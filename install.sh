main() {
  set -e

  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi

  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    BLUE="$(tput setaf 4)"
    YELLOW="$(tput setaf 3)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    BLUE=""
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

  if [ -d "./$LARADOCK_FOLDER" ] || [ -f "./docker-compose.yml" ]; then
    printf "${YELLOW}"
    echo ''
    echo "It appears that you already have docker installed for your project."
    echo "You'll need to remove the folder ./$LARADOCK_FOLDER and the file ./docker-compose.yml you want to continue."
    echo ''
    printf "${NORMAL}"
    exit 1
  fi

  umask g-w,o-w

  printf "${BLUE}"
  echo ''
  echo 'Cloning DevSquad Laradock...'
  echo ''
  printf "${NORMAL}"

  command -v git >/dev/null 2>&1 || {
    printf "${BLUE}"
    echo ''
    echo "git is not installed."
    echo ''
    printf "${NORMAL}"

    exit 1
  }

  if [ "$OSTYPE" = cygwin ]; then
    if git --version | grep msysgit > /dev/null; then
      printf "${RED}"
      echo ''
      echo 'Error: Windows/MSYS Git is not supported on Cygwin.'
      echo 'Error: Make sure the Cygwin git package is installed and is first on the path.'
      echo ''
      printf "${NORMAL}"
      exit 1
    fi
  fi

  env git clone --depth=1 https://github.com/teamdevsquad/laradock.git "$LARADOCK_WORKSPACE" || {
    printf "${RED}"
    echo ''
    echo 'Error: git clone of teamdevsquad/laradock repo failed'
    echo ''
    printf "${NORMAL}"
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