/* Parser implementation using Bison */

%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern int yyparse();
extern FILE *yyin;
extern int line_num;

void yyerror(const char* s);
%}


/* Define values */
%union{
	int ival;
	char *sval;
	char* kval;
	char* oval;
	char* bval;
}

/* Define constant-string tokens: */
%token END ENDL

/* Define terminal symbols: */
%token <ival> INT;
%token <sval> IDENTIFIER;
%token <kval> KEYWORD;
%token <oval> OPERATOR;
%token <bval> BINARY;
%%
c_legacy:

	c_legacy KEYWORD IDENTIFIER OPERATOR {printf("Bison found a new method:  %s\n", $3);}
	| c_legacy KEYWORD IDENTIFIER {printf("Bison found a new variable declaration: %s\n", $3);}
	| c_legacy KEYWORD {printf("Bison found a keyword: %s\n", $2);}
	| c_legacy OPERATOR {printf("Bison found a operator: %s\n", $2);}
	| c_legacy INT {printf("Bison found a int: %d\n", $2);}
	| c_legacy BINARY {printf("Bison found a binary: %s\n", $2);}
	| c_legacy IDENTIFIER {printf("Bison found a identifier: %s\n", $2);}
	| KEYWORD IDENTIFIER OPERATOR {printf("Bison found a new method %s\n", $2);}
	| KEYWORD IDENTIFIER {printf("Bison found a new variable declaration: %s\n", $2);} 
	| KEYWORD {printf("Bison found a keyword: %s\n", $1);}
	| OPERATOR {printf("Bison found a operator: %s\n", $1);}
	| INT {printf("Bison found a int: %d\n", $1);}
	| BINARY {printf("Bison found a hex: %s\n", $1);}
	| IDENTIFIER {printf("Bison found a identifier: %s\n", $1);}
	;
%%

int main(int argc, char* argv[]){

	/* Open a file handle */
	FILE *fptr;

	// Check the argument is supplied
	if( argc == 2 ) {
		fptr = fopen(argv[1], "r");
    	printf("The file evaluated is: %s\n", argv[1]);
		/* Set flex to read the file */
		yyin =fptr;
		/* Parse through the input */
		yyparse();
		/* Close the file */
		fclose(fptr); 
   	}else if( argc > 2 ) {
      	printf("Too many arguments supplied. Require one file path.\n");
   	}else {
      	printf("Require File path.\n");
   	}

}

void yyerror(const char *s){
	/* When lex is not right, return an error.*/
	printf("PARSE ERROR ON LINE: %d\n", line_num++);
	/* Halt */
	exit(-1);
}

