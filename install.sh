#!/bin/bash

clear

HERE=`dirname $0`
UNIXTIMESTAMP=`date +"%s"`
H1='\e[47m\e[1;44m'
B='\e[1m'
BR='\n\n'
TXTRST='\e[0m'

install_this() {

    check_dependencies;

    echo -e "$BR$H1 -- Start setup -- $TXTRST$BR$B Please note!!!$BR$TXTRST Your current $B.vim$TXTRST directory and $B.vimrc$TXTRST file will be backed-up with$B _$UNIXTIMESTAMP$TXTRST suffix. Continue ? [ Y/n ]"

    read -sn 1 SETUP

    if [[ $SETUP = 'y' || $SETUP = '' ]]; then
        echo -e "$BR$H1 -- Runing setup -- $TXTRST$BR"

        if [ -f $HOME/.vimrc ]; then
            mv $HOME/.vimrc $HOME/.vimrc_$UNIXTIMESTAMP
        fi
        if [ -d $HOME/.vim ]; then
            mv $HOME/.vim $HOME/.vim_$UNIXTIMESTAMP
        fi
        cp -r $HERE/.vim $HERE/.vimrc $HOME

        git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim

        vim +BundleInstall +qall

        echo -e "$BR$H1 -- <[ INSTALLATION FINISHED ]> -- $TXTRST$BR\e[47m\e[1;42m :) $TXTRST$BR"

        keep_backups_or_not;

    else
        echo -e "$BR$H1 -- Aborted -- $TXTRST"
    fi
}

check_dependencies() {
    vim --version 2>&1 >/dev/null && git --version 2>&1 >/dev/null
    if [ $? -ne 0 ]; then
        echo -e "$BR$H1 -- Dependencies not met -- $TXTRST $BR$H1 :( $TXTRST $BR You need$B vim$TXTRST and$B git$TXTRST installed for this to work $BR"
        exit 1
    fi
}

keep_backups_or_not() {
    echo -e "$BR Do you want to keep the $B.vim_$UNIXTIMESTAMP$TXTRST and $B.vimrc_$UNIXTIMESTAMP$TXTRST backups. [Y/n]"
    read -sn 1 KEEP_BACKUPS
    if [[ $KEEP_BACKUPS = 'y' || $KEEP_BACKUPS = '' ]]; then
        echo -e "$BR$H1 -- Keeping backups -- $TXTRST$BR"
    else
        rm -rf $HOME/.vimrc_$UNIXTIMESTAMP $HOME/.vim_$UNIXTIMESTAMP
        echo -e "$BR$H1 -- Backups removed -- $TXTRST$BR"
    fi
}
# Run
install_this;