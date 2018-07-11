#!/bin/bash

if [ -d "~/.zsh_history" ]
    then rm -Rf ~/.zsh_history && touch ~/.zsh_history;
fi

git config gitflow.branch.master master \
&& git config gitflow.branch.develop develop \
&& git config gitflow.prefix.feature feature/ \
&& git config gitflow.prefix.bugfix bugfix/ \
&& git config gitflow.prefix.release release/ \
&& git config gitflow.prefix.hotfix hotfix/ \
&& git config gitflow.prefix.support support/ \
&& git config gitflow.prefix.versiontag v \
&& git config gitflow.path.hooks .git/hooks
