# source /home/nikos/bin/binaries/peda/peda.py
# source /home/nikos/bin/binaries/pwndbg/gdbinit.py
# source /home/nikos/bin/binaries/.gdbinit-gef.py

define init-gef
source ~/bin/binaries/.gdbinit-gef.py
end
document init-gef
Initializes GEF (GDB Enhanced Features)
end

set history save
set disassembly-flavor intel
set follow-fork-mode child
init-gef

