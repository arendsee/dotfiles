#!/bin/bash

# fix for java
# update-alternatives --install /usr/bin/java java $path_to_java 100

alias parallel='parallel --gnu'
alias ltree='tree -C | less -R'
alias fbasename='while read line; do basename $line; done'
alias rmblastdb='rm *.{nhr,nin,nsq,phr,pin,psq} 2> /dev/null'
alias csa='git commit -S -m '
alias cpan='perl -MCPAN -e shell'
alias R='R --vanilla --quiet'
alias seg='segmasker -outfmt fasta'
alias x='exit'

# Compile a knitr document
knit () {
    [[ ${1/*./} == Rnw ]] || { echo "Input must be a *.Rnw file" >&2; return 1 ; }
    Rscript -e "library(knitr); knit('$1')"
    [[ $? == 0 ]] || { echo "Failed to knit ..." >&2; return 1 ; }
    latexmk --pdf --bibtex ${1%.Rnw}.tex
}


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

# View image of a PDB file (requires pymol)
function seepdb { 
    if command -v pymol 2> /dev/null
    then
        for f in $@
        do
            if [[ -r $f ]]
            then
                tmpfile=/tmp/$(basename $f).png
                pymol $f -qc -d 'hide all; show cartoon; spectrum' -g $tmpfile 2> /dev/null > /dev/null
                eog $tmpfile
                rm $tmpfile
            fi
        done
    else
        echo "pymol not in PATH" >&2
    fi
}

# Convert PDB files to images (requires pymol)
function pdb2png {
    if command -v pymol 2> /dev/null
    then
        for f in $@
        do
            if [[ -r $f ]]
            then
                out=$(sed 's/pdb$/png/' <<< `basename $f`)
                pymol $f -qc -d 'hide all; show cartoon; spectrum' -g $out
            fi
        done
    else
        echo "pymol not in PATH" >&2
    fi
}

# Parallel zipping/unzipping functions
function pgzip    { ls $@ | xargs -P `nproc` -n 1 gzip;    }
function pbzip2   { ls $@ | xargs -P `nproc` -n 1 bzip2;   }
function pgunzip  { ls $@ | xargs -P `nproc` -n 1 gunzip;  }
function pbunzip2 { ls $@ | xargs -P `nproc` -n 1 bunzip2; }

# Shred files
function annihilate {
    for j in $@
    do
        shred -fuzn 1 $j
    done
}

# general opener (adapt as necessary)
function sesame {
    for j in $@
    do
        gnome-open $j
    done
}

function cds { cd "$1"; ls; }

function ma {
    for j in `ls *mp3 *wav *flac`
    do
        mplayer $j
    done
}

# Moves a file to the recycle bin
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
        jar_dir=$(sed -e 's/\.jar$//' <<< $j)
        mkdir $jar_dir
        mv $j $jar_dir
        cd $jar_dir
        jar -xvf $j
        mv $current_directory/$jar_dir/$j $current_directory
        cd $current_directory
    done
}

# Encrypts a directory with a symmetric cypher, shreds originals
function encrypt-dir {
    # If the input is not a directory, directly encrypt it
    if [ ! -d $1 ]; then
        echo 'This command is intended for directories, but, yeah whatever'  >&2
        gpg --cipher-algo TWOFISH -c $1
        return 0
    fi

    # Remove trailing slash (if present) from input directory name
    indir=$(perl -pe 's|/$||' <<< $1)

    # Create tarball
    tarfile="$indir.tar"
    tar -cf "$tarfile" "$indir"

    # If archiving fails, shred tarball and die
    if [ $? -ne 0 ]; then
        echo "Archiving fail, shredding tar file" >&2
        shed -zuf "$tarfile" 
        return 1
    fi

    # Encrypt tarball
    gpg --cipher-algo TWOFISH -c "$tarfile"

    # If encryption fails, shred tarball and die
    if [ $? -ne 0 ]; then
        echo "Encryption fail, removing broken files" >&2
        shred -zuf "$tarfile"
        rm "$indor.tar.gpg"
        return 1
    else
        shred -zuf "$tarfile"
    fi

    # Shred unencrypted original data
    gpgfile="$tarfile.gpg"
    if [ -f "$gpgfile" ]; then

        echo "Shredding original folder, please wait ..." >&2

        path=$PATH
        export PATH='/usr/local/bin:/usr/bin'
        find $indir/ -type f -execdir shred -zuf \{\} \;
        export PATH=$path

        if [ $? -ne 0 ]; then
            echo "Find failed, input directory $indir was NOT shredded or removed" >&2
            echo "But folder was encrypted successfuly" >&2
        else
            rm -Rf $indir
        fi

        return 0
    else 
        echo "Seems something didn't work, no .gpg output" >&2
        return 1
    fi
}

# Decrypts encrypted folder
function decrypt-dir {
    if [ -f $1 ]; then
        gpg -d $1 | tar --keep-newer-files -xf -
    else
        echo "Cannot open file $1" >&2
        return 1
    fi
}
