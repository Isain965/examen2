# Examen 2nd block

# Autores: 
 * Isain Cuara Rivas
 * Diego Canizales Bollain Goytia


# Description
A compiler for the BITWISE language
### Scanner, Parser and Intermediate-code implementation.

## Dependecies 
	```
	sudo apt-get update
	sudo apt-get install flex
	sudo apt-get install bison
	```
## Commands to Run Program

	1)	You can simply run the Makefile:
			./make
		And then run the program, which outputs to clegacy:
			./analizer


	2)	You can compile the code yourslef:	
		
		```
			bison -d bitwise.y
			flex bitwise.l
			gcc bitwise.tab.c lex.yy.c -lfl -o analizer
		```

## Functionality:
* Simple language for bitwise operations between hex or binary numbers.
* Operations included in this language are NOT,AND,OR,NAND,XOR,represented by the operators !, *, +, &, #, respectively.
* Includes an assignment instruction.
* A binary is a sequence of 8 binary digits.
* A hexadecimal starts with 0X or 0x followed by hex digits. Includes a-f and A-F.
* An identifier is a sequence of letters, digits and underscores that start with a letter.
* Includes a instruction block between this {}  

# Example entries
### Correct code
* bin a; bin b; {a = 10100011; b = 11101100;}
* hex a; hex b; {a = 0xF; b = 0x1;}
* bin a; hex b; {a = 10101010; b = 0xB;}
* bin a; bin c; {c = a;}
### Wrong code
* bin a; bin b; {c = 10100011; d = 11101100;}
* hex a; hex b; {c = 0xF; d = 0x1;}
* bin a; hex b; {a = 10101010; b = 0xB}
* bin a; hex b; {a = 0xB; b = 10101010;}
* bin a; bin c; hex h; {c = h;}