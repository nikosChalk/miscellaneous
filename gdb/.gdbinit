# source /home/nikos/bin/binaries/peda/peda.py
# source /home/nikos/bin/binaries/pwndbg/gdbinit.py
# source /home/nikos/bin/binaries/.gdbinit-gef.py

define init-peda
source ~/bin/binaries/peda/peda.py
end
document init-peda
Initializes the PEDA (Python Exploit Development Assistant for GDB) framework
end

define init-pwndbg
source ~/bin/binaries/pwndbg/gdbinit.py
end
document init-pwndbg
Initializes PwnDBG
end

define init-gef
source ~/bin/binaries/.gdbinit-gef.py
end
document init-gef
Initializes GEF (GDB Enhanced Features)
end

set history save
set disassembly-flavor intel
set follow-fork-mode child

