
# user defined (by nikos) #
export JAVA_HOME="/usr/lib/jvm/default-java"
export PATH="$PATH:/home/$USER/.openmpi/bin"
export PATH="$PATH:/home/$USER/bin/binaries"
export PATH="$PATH:$JAVA_HOME/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/$USER/.openmpi/lib"

export VISUAL=vim
export EDITOR="$VISUAL"

# for pyenv
export PATH="/home/nikos/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# requires ghostscript. Sample call: pdfmerge merged.pdf page1.pdf page2.pdf
# sudo apt-get install ghostscript
pdfmerge() { gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile=$@ ; }

