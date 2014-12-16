#!/bin/bash

# fix for java
# update-alternatives --install /usr/bin/java java $path_to_java 100

alias parallel='parallel --gnu'
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
alias atfaa="cat /db/cheshire-data/nuclear-genomes/phytozome/Arabidopsis_thaliana.faa"
alias atfna="cat /db/cheshire-data/nuclear-genomes/phytozome/Arabidopsis_thaliana.fna"
alias atcds="cat /db/cheshire-data/nuclear-genomes/phytozome/Arabidopsis_thaliana.cds.fna"
alias attra="cat /db/cheshire-data/nuclear-genomes/phytozome/Arabidopsis_thaliana.transcript.fna"
alias atgff="cat /db/cheshire-data/nuclear-genomes/phytozome/Arabidopsis_thaliana.gene_exons.gff3"

# View image of a PDB file (requires pymol)
function seepdb { 
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
}

# Convert PDB files to images (requires pymol)
function pdb2png {
    for f in $@
    do
        if [[ -r $f ]]
        then
            out=$(sed 's/pdb$/png/' <<< `basename $f`)
            pymol $f -qc -d 'hide all; show cartoon; spectrum' -g $out
        fi
    done
}

# Parallel zipping/unzipping functions
function pgzip    { ls $@ | xargs -P `nproc` -n 1 gzip;    }
function pbzip2   { ls $@ | xargs -P `nproc` -n 1 bzip2;   }
function pgunzip  { ls $@ | xargs -P `nproc` -n 1 gunzip;  }
function pbunzip2 { ls $@ | xargs -P `nproc` -n 1 bunzip2; }

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

function gccp {
    g++ -ansi -pedantic-errors -Wall $1 $2 $3
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
        jar_dir=`echo $j | sed -e 's/\.jar$//'`
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
        echo 'This command is intended for directories, but, yeah whatever'
        gpg --cipher-algo TWOFISH -c $1
        return 0
    fi

    # Remove trailing slash (if present) from input directory name
    indir=`echo $1 | perl -pe 's|/$||'`

    # Create tarball
    tarfile="$indir.tar"
    tar -cf "$tarfile" "$indir"

    # If archiving fails, shred tarball and die
    if [ $? -ne 0 ]; then
        echo "Archiving fail, shredding tar file"
        shed -zuf "$tarfile" 
        return 1
    fi

    # Encrypt tarball
    gpg --cipher-algo TWOFISH -c "$tarfile"

    # If encryption fails, shred tarball and die
    if [ $? -ne 0 ]; then
        echo "Encryption fail, removing broken files"
        shred -zuf "$tarfile"
        rm "$indor.tar.gpg"
        return 1
    else
        shred -zuf "$tarfile"
    fi

    # Shred unencrypted original data
    gpgfile="$tarfile.gpg"
    if [ -f "$gpgfile" ]; then

        echo "Shredding original folder, please wait ..."

        path=$PATH
        export PATH='/usr/local/bin:/usr/bin'
        find $indir/ -type f -execdir shred -zuf \{\} \;
        export PATH=$path

        if [ $? -ne 0 ]; then
            echo "Find failed, input directory $indir was NOT shredded or removed"
            echo "But folder was encrypted successfuly"
        else
            rm -Rf $indir
        fi

        return 0
    else 
        echo "Seems something didn't work, no .gpg output"
        return 1
    fi
}

# Decrypts encrypted folder
function decrypt-dir {
    if [ -f $1 ]; then
        gpg -d $1 | tar --keep-newer-files -xf -
    else
        echo "Cannot open file $1"
        return 1
    fi
}
