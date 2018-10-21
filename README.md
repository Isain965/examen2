# Flex-Bison
# Autores: 
 * Arturo Velazquez Rios
 * Isain Cuara Rivas
 * Diego Canizales Bollain Goytia


A compiler for the C-- language

### Scanner implementation recognize tokens and print them out 
## Dependecies 
	```
	sudo apt-get update
	sudo apt-get install flex
	sudo apt-get install bison
	```
## Commands to Run Program

	1)	You can simply run the Makefile:
			./Makefile
		And then run the program, which outputs to clegacy:
			./clegacy "path/to/source/program/in/c"


	2)	You can compile the code yourslef:	
		
		```
			bison -d clegacy.y
			flex clegacy.l
			gcc clegacy.tab.c lex.yy.c -lfl -o clegacy

		And then run the program with:
			./clegacy "path/to/source/program/in/c"
		```

## Functionality:
	* 1.  Ignore blank spaces
	* 2.  Ignore comments
	* 3.  Recognize keywords and return their token category
	* 4.  Recognize delimiters and one-character operators and return their ASCII code as their token category
	* 5.  Recognize two-character operators and return their token category
	* 6.  Recognize  integer,  double,  and  boolean  constants,  and  return  their  token  categoryand their value
	* 7.  Recognize identifiers and return their token category.  In addition, if the identifier has not been identified, the identifier must be entered into the symbol table; if the identifier has been already identified, their number of occurrences must be incremented.
	* 8.  Print a generic error message for illegal tokens, indicating the line number where the error occurs.
 	*/
