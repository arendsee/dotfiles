#! /bin/bash

# fix for java
# update-alternatives --install /usr/bin/java java $path_to_java 100

alias ltree='tree -C | less -R'
alias fbasename='while read line; do basename $line; done'
alias rmblastdb='rm *.{nhr,nin,nsq,phr,pin,psq} 2> /dev/null'
alias csa='git commit -S -m '
# This is for my vim built from source
# alias vi='/usr/local/bin/vim'
alias cpan='perl -MCPAN -e shell'
alias R='R --vanilla --quiet'
alias seg='segmasker -outfmt fasta'
alias x='exit'


# Color associated aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -v --color=auto -X'
    alias ll='ls -v --color=auto -X -alhF'
    alias la='ls -v --color=auto -X -A'
    alias l='ls -v --color=auto -X -CF'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias less='less -R'
fi


# cat Arabidopsis thaliana full genome sequences
alias atfaa="cat $HOME/ohome/data/genomes/at/Arabidopsis_thaliana.protein.faa"
alias atfna="cat $HOME/ohome/data/genomes/at/Arabidopsis_thaliana.fna"
alias atcds="cat $HOME/ohome/data/genomes/at/Arabidopsis_thaliana.CDS.fna"

# Parallel zipping/unzipping functions
function pgzip    { ls $@ | xargs -P 0 -n 1 gzip    }
function pbzip2   { ls $@ | xargs -P 0 -n 1 bzip2   }
function pgunzip  { ls $@ | xargs -P 0 -n 1 gunzip  }
function pbunzip2 { ls $@ | xargs -P 0 -n 1 bunzip2 }

# Remove files created when building tex
function rmtexjunk {
    if [ -f ${1}.tex ]; then
        for j in aux bbl blg lof log out toc fdb_latexmk pdf dvi; do
            rm "${1}.$j" 2> /dev/null
        done
    else
        echo "Please provide tex base filename"
        return 1
    fi
}

# Shred files
function annihilate {
    for j in $@
    do
        shred -fuzn 1 $j
    done
}

# general opener
function sesame {
    for j in $@
    do gnome-open $j
    done
}

function cds { cd "$1"; ls; }

function ma {
    for j in `ls *mp3 *wav *flac`
    do
        mplayer $j
    done
}

function gccp {
    g++ -ansi -pedantic-errors -Wall $1 $2 $3
}

function damn {
    for j in $@;
    do
        mv -f $j ~/.local/share/Trash/files
    done
}

function unjar {
    for j in $@
    do 
        current_directory=$PWD
        jar_dir=`echo $j | sed -e 's/\.jar$//'`
        mkdir $jar_dir
        mv $j $jar_dir
        cd $jar_dir
        jar -xvf $j
        mv $current_directory/$jar_dir/$j $current_directory
        cd $current_directory
    done
}
