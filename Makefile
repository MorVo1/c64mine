out: program.asm
	64tass -CaBi --cbm-prg program.asm -o c64mine.prg
run:
	x64 c64mine.prg
