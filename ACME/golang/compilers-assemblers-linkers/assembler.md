https://www.youtube.com/watch?v=KINIAgRpkDA
.net/java/python is to byte code as go assembly is to psuedo instructions
# old way 
gcc: compile->assembly->link // in the assembler text instructions become psuedo instructions fed into the linker
plan 9: compile->link 
plan 9: assembly->link // assembler is a c program that uses the yacc grammar

Old plan 9 assembler
The assembler is a c program that uses the yacc grammar

go 1.3 moved to pure go assembler
The assembler/compiler is doing the instruction selection that the linker used to do.
A new lib 'obj' is used by the compiler and assembler
New: compile->link
New Way: assembly->link  // The assembler is a go program that calls the obj library to do the instruction selection
There is nothing like the go assembler which takes textual instructions and converts them to pseudo instructions.

Obj library:
Is a set of libraries
Has architecture dependant parts.

Since Go 1.5:
the go compilers g6,g8 etc were replaced by a single tool which accepts 2 environment variables
GOOS=darwin GOARCH=arm go tool compile prog.go
The same for the linkers 61,81, etc. became go tool link
How can a single compiler handle all these architectures since cross compiling is really difficult.
Only one input language Go and only one output generator the Obj library.
Replaced all the assemblers with a single tool go tool asm
Psuedo instructions that come out of the compiler's stat stage looks like assembly
Psuedo instructions is a common assembly language for machines which is based on the National 32000 assembler the offsets are different based on the word size but for the most part it is a common assembly language across machines.  The downside is it does not look like the regular assembly language used by the machine.

New Go Assembler
One syntax for all machines.
Written entirely in Go.
common lexer and parser
