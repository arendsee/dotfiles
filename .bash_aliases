#!/bin/bash

# fix for java
# update-alternatives --install /usr/bin/java java $path_to_java 100

# Chinese corpus lookup
function z () {
    echo " -- from news 10K"
    grep --color=always $@ ~/.corpus/leipzig/zho_news_2007-2009_10K-sentences.txt
    echo " -- from web 10K"
    grep --color=always $@ ~/.corpus/leipzig/zho-simp-tw_web_2014_10K-sentences.txt
}

function zz () {
    echo " -- from news 1M"
    grep --color=always $@ ~/.corpus/leipzig/zho_news_2007-2009_1M-sentences.txt
    echo " -- from web 300K"
    grep --color=always $@ ~/.corpus/leipzig/zho-simp-tw_web_2014_300K-sentences.txt
}

function zf () {
    grep -oh --color=never $@ ~/.corpus/leipzig/zho_news_2007-2009_1M-sentences.txt ~/.corpus/leipzig/zho-simp-tw_web_2014_300K-sentences.txt | sort | uniq -c | sort -g
}

# =============================================================================
# Haskell functions
function stack-new (){
   stack new $1
}

function stack-build (){
    stack build --fast --ghc-options -Wall && stack install && stack test --fast
}

function stack-view (){
    # `stack haddock` alone will build the documentation for a project
    stack haddock --open $1
}

function browse (){
    ghci -e ":browse $1"
}

function py-setup (){
    pkg=$(basename `pwd`)
    rm -rf build dist *.egg-info/ && pip3 uninstall ${pkg} && python3 setup.py sdist bdist_wheel && pip3 install dist/${pkg}*whl
}

# =============================================================================
# Utility functions
function works_(){
    $1 > /dev/null 2>&1
    if [[ $? -eq 0 ]]
    then
        echo 1
    else
        echo 0
    fi
}
# =============================================================================

function h() {
    column -t -s $'\t' $1
}

function ddate() {
    # To find the appropriate TZ, use `tzselect`
    # echo "central:"
    TZ=America/Chicago date
    # echo "china:"
    # TZ=Asia/Shanghai date
    echo
    cal -m -n 6
}

function weather() {
    curl http://wttr.in
}

function pdf2eps() {
    # adapted from Herbert Voss's answer to stackoverflow question 20883
    # Convert PDF to encapsulated PostScript.
    # usage:
    # pdf2eps <page number> <pdf file without ext>
    pdfcrop $2.pdf
    pdftops -f $1 -l $1 -eps "$2-crop.pdf" 
    rm  "$2-crop.pdf"
    mv  "$2-crop.eps" $2.eps
}

function xgrep() {
   mkdir .xgrep
   cp $1 .xgrep
   cd .xgrep
   tar -xf $1
   shift
   cd ..
   cat .xgrep/xl/*xml .xgrep/xl/worksheets/*xml | grep $@
   rm -rf .xgrep
}


alias vi=vim

# get external IP address
alias ipe='curl ipinfo.io/ip'

# # get internal IP address (doesn't currently work)
# alias ipi='ipconfig getifaddr en0'

# Get random password
alias getpass="openssl rand -base64 20"

# =============================================================================
# Media
alias vvs='pamixer --set-volume '
alias vvg='pamixer --get-volume '
# =============================================================================


# =============================================================================
# Git
alias ggs='git status '
alias ggc='git commit '
alias ggcam='git commit -am ' # stage everything and write a message
alias ggm='git merge --no-ff --no-commit '
alias gga='git add '
alias ggb='git branch '
alias ggp='git push origin '
alias ggd='git diff --color-moved --word-diff -M9'
alias ggg='git log --graph'
alias unamend='git reset --soft HEAD@{1}'
alias gg2m='git push origin master'
alias gg2d='git push origin dev'
function gcl() {
    repo=$1
    user=${2-arendsee}
    git clone "https://github.com/$user/$repo"
}
function overleaf-commit() {
    git pull origin master && minor-commit "$@"
}
function minor-commit() {
    if [[ -z "$1" ]]
    then
        msg=minor
    else
        msg="$1"
    fi
    git add -A && git commit -m "$msg" && git push origin master
}

# commit and push to overleaf
alias ggco='git add -A; git commit -m "edit"; git push origin master'
# =============================================================================

# =============================================================================
# Blogging
rpost (){
    filename=$(date +%Y-%m-%d-)$1.Rmd
    touch $filename
}
jpost (){
    filename=$(date +%y-%m-%d-)$1.md
    touch $filename
}


# =============================================================================
# Miscellaneous aliases
# =============================================================================

function ?() {
    if [[ $(works_ "man $1") -eq 1 ]]
    then
        man $1
    elif [[ $(works_ "$1 --help") -eq 1 ]]
    then
        $1 --help | less
    elif [[ $(works_ "$1 -help") -eq 1 ]]
    then
        $1 -help | less
    elif [[ $(works_ "$1 -h") -eq 1 ]]
    then
        $1 -h | less
    elif [[ -f $1 ]]
    then
        file $1
    elif [[ -d $1 ]]
    then
        ltree $1
    else
        echo "Could not find help" >&2
    fi
}

alias parallel='parallel --gnu'
alias fbasename='while read line; do basename $line; done'
alias cpan='perl -MCPAN -e shell'
alias R='R --quiet'
alias seg='segmasker -outfmt fasta'
alias x='exit'
alias lynx='lynx -vikeys -homepage=www.google.com'
alias t='tmux -2' # the `-2` forces color256
alias info='info --vi-keys' 

# =============================================================================
# Git functions
# =============================================================================

function gitallstatus() {
    for d in `/usr/bin/ls -d $HOME/src/git/*`
    do
        cd $d
        echo -------------------------------------------------------------------
        echo $PWD
        git status
        echo -------------------------------------------------------------------
        echo
        cd - > /dev/null
    done
}


# =============================================================================
# Directory navigation
# =============================================================================

# Color associated aliases
if [ "$(uname)" = "Darwin" ]
then
    alias ls='ls -vG'
    alias ls='ls -vG'
    alias ll='ls -alhFG'
    alias la='ls -AG'
    alias l='ls -CFG'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias less='less -R'
elif [ -x /usr/bin/dircolors ]
then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -v --color=auto'
    alias ll='ls -alhF'
    alias la='ls -A'
    alias l='ls -CF'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias less='less -R'
fi

function cd_ls {
    if [[ -z $1 ]]
    then
        cd ; ls
    else
        cd "$1"; ls
    fi
}

alias ,="cd_ls"
alias ,.='cd_ls -'
alias ..='cd_ls ..'
alias ...='cd_ls ../..'
alias ....='cd_ls ../../..'
alias .....='cd_ls ../../../..'
alias ......='cd_ls ../../../../..'

alias ..2='cd_ls ../..'
alias ..3='cd_ls ../../..'
alias ..4='cd_ls ../../../..'
alias ..5='cd_ls ../../../../..'
alias ..6='cd_ls ../../../../../..'

function gotoGit {
    gitbase=$1
    gitname=$2
    n=$(ls -d $gitbase/${gitname}* | wc -l)
    if [ $n -eq 1 ]
    then
        cd $gitbase/${gitname}*; ls
    else
        cd $gitbase/$gitname 2> /dev/null || cd $gitbase; ls
    fi
}
alias ,,="gotoGit $HOME/src/git"
alias ,,,="gotoGit $HOME/.morloc/lib"

# colorfully pipe tree to less
function ltree {
   tree -C "$@" | less -R
}



# =============================================================================
# IO
# =============================================================================

function vector-convert {
    parallel 'convert {} -density 300 -quality 100 -trim -sharpen 0x2.0 -resize 200% {.}.png' ::: "$@"
}

# View image of a PDB file (requires pymol)
function seepdb { 
    if command -v pymol 2> /dev/null
    then
        for f in "$@"
        do
            if [[ -r "$f" ]]
            then
                tmpfile=/tmp/$(basename "$f").png
                pymol "$f" -qc -d 'hide all; show cartoon; spectrum' -g "$tmpfile" 2> /dev/null > /dev/null
                o "$tmpfile"
                rm "$tmpfile"
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
        for f in "$@"
        do
            if [[ -r "$f" ]]
            then
                out=$(sed 's/pdb$/png/' <<< `basename "$f"`)
                pymol "$f" -qc -d 'hide all; show cartoon; spectrum' -g "$out"
            fi
        done
    else
        echo "pymol not in PATH" >&2
    fi
}

alias oloop="mplayer -loop 0"

function saturn {
    cd $HOME/music/noise
    echo ">>> $1 -- $(date)" >> $HOME/.timesheet
    mplayer saturn.mp3
    echo "<<< $1 -- $(date)" >> $HOME/.timesheet
    mplayer water.mp3
}

# general opener (adapt as necessary)
# run non-cli programs in the background
function o {
    if [ "$(uname)" = "Darwin" ]
    then
        open "$@"
    else
        for j in "$@"
        do
            echo "$j"
            if [[ "$j" =~ \.(png|jpg|jpeg|gif|tiff)$ ]]; then
                feh "$j" &
            elif [[ "$j" =~ \.dot$ ]]; then
                tempfile=/tmp/$RANDOM.svg
                dot -Tsvg "$j" -o $tempfile 
                inkscape $tempfile 
                rm $tempfile
            elif [[ "$j" =~ \.(doc|docx|odt|ppt|pptx|xlsx)$ ]]; then
                libreoffice "$j" &
            elif [[ "$j" =~ \.(mp3|wav|flac)$ ]]; then
                mplayer "$j"
            elif [[ "$j" =~ \.(html)$ ]]; then
                chromium "$j" || firefox $j &
            elif [[ "$j" =~ \.(svg)$ ]]; then
                inkscape "$j" &
            elif [[ "$j" =~ \.(pdf|dvi|ps|eps)$ ]]; then
                atril "$j" || zathura "$j" &
            elif [[ "$j" =~ \.(pdb)$ ]]; then
                pymol "$j" || vi "$j" &
            elif [[ "$j" =~ \.(txt|md|tex)$ ]]; then
                vi +Goyo +HardPencil -u ~/.goyo.vimrc "$j"
            elif [[ -d "$j" ]]; then
                vi "$j"
            elif [[ `file "$j"` =~ (ASCII text|empty) ]]; then
                vi +Goyo +HardPencil -u ~/.goyo.vimrc "$j"
            elif [[ `file "$j"` =~ 'ELF' ]]; then
                vi -c Vinarise "$j"
            else
                echo "I don't know how to open this" >&2
                return 1
            fi
        done
    fi
}
alias open=o

function tokindle() {
    input=$1
    output=$2
    k2pdfopt                    \
        -o $2                   \
        -dev kpw                \
        -col 1                  \
        -wrap-                  \
        -x                      \
        -om 0.04 0.04 0.04 0.04 \
        $1
}

function vih() {
    vi -c "help $1 | only"
}


# for cd
# $ mplayer -cdrom-device /dev/sr0 cdda:// # or wherever the socket is
function ma {
    for j in `ls *mp3 *wav *flac`
    do
        mplayer "$j"
    done
}



# =============================================================================
# File deletion, compression, and encryption
# =============================================================================

# Parallel zipping/unzipping functions
function pgzip    { ls $@ | xargs -P `nproc` -n 1 gzip;    }
function pbzip2   { ls $@ | xargs -P `nproc` -n 1 bzip2;   }
function pgunzip  { ls $@ | xargs -P `nproc` -n 1 gunzip;  }
function pbunzip2 { ls $@ | xargs -P `nproc` -n 1 bunzip2; }

function unjar {
    for j in "$@"
    do 
        current_directory=$PWD
        jar_dir=$(sed -e 's/\.jar$//' <<< "$j")
        mkdir "$jar_dir"
        mv "$j" "$jar_dir"
        cd "$jar_dir"
        jar -xvf "$j"
        mv "$current_directory"/"$jar_dir"/"$j" "$current_directory"
        cd "$current_directory"
    done
}

# Shred files
function annihilate {
    for j in "$@"
    do
        shred -fuzn 1 "$j"
    done
}

# Moves a file to the recycle bin
function damn {
    for j in "$@";
    do
        mv -f "$j" ~/.local/share/Trash/files
    done
}

# Encrypts a directory with a symmetric cypher, shreds originals
function encrypt-dir {
    # If the input is not a directory, directly encrypt it
    if [ ! -d "$1" ]; then
        echo 'This command is intended for directories, but, yeah whatever'  >&2
        gpg --cipher-algo TWOFISH -c "$1"
        return 0
    fi

    # Remove trailing slash (if present) from input directory name
    indir=$(perl -pe 's|/$||' <<< "$1")

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
        find "$indir"/ -type f -execdir shred -zuf \{\} \;
        export PATH=$path

        if [ $? -ne 0 ]; then
            echo "Find failed, input directory "$indir" was NOT shredded or removed" >&2
            echo "But folder was encrypted successfuly" >&2
        else
            rm -Rf "$indir"
        fi

        return 0
    else 
        echo "Seems something didn't work, no .gpg output" >&2
        return 1
    fi
}

# Decrypts encrypted folder
function decrypt-dir {
    if [ -f "$1" ]; then
        gpg -d "$1" | tar --keep-newer-files -xf -
    else
        echo "Cannot open file $1" >&2
        return 1
    fi
}



# =============================================================================
# Stuff that ought to be in a Makefile
# =============================================================================

# Compile a knitr document
knit () {
    [[ "${1/*./}" == Rnw ]] || { echo "Input must be a *.Rnw file" >&2; return 1 ; }
    Rscript -e "library(knitr); knit('$1')"
    [[ $? == 0 ]] || { echo "Failed to knit ..." >&2; return 1 ; }
    latexmk --pdf --bibtex "${1%.Rnw}".tex
}

knitmd () {
    [[ "${1/*./}" == Rmd ]] || { echo "Input must be an *.Rmd file" >&2; return 1 ; }
    Rscript -e "library(knitr); knit('$1')"
    [[ $? == 0 ]] || { echo "Failed to knit ..." >&2; return 1 ; }
	pandoc -f markdown+table_captions -V geometry:margin=1in -o ${1%.Rmd}.pdf ${1%.Rmd}.md
}

alias rmblastdb='rm *.{nhr,nin,nsq,phr,pin,psq} 2> /dev/null'



# =============================================================================
# Tabular file handling 
# =============================================================================
header() {
    head -1 "$1" |
        tr "\t" "\n" |
        awk '{print NR"\t"$0}'
}

nth() {
    head -n $1 "$2" | tail -n 1
}
