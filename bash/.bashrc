
# user defined (by nikos) #
export PATH="$PATH:/home/$USER/.openmpi/bin"
export PATH="$PATH:/home/$USER/bin/binaries"
export PATH="$PATH:~/grin"
export PATH="$PATH:~/grin-miner/target/debug"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/$USER/.openmpi/lib"

# requires ghostscript. Sample call: pdfmerge merged.pdf page1.pdf page2.pdf
# sudo apt-get install ghostscript
pdfmerge() { gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile=$@ ; }

