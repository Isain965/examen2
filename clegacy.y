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
	float fval;
	char *sval;
	char* kval;
	char* oval;
	char* doval;
}

/* Define constant-string tokens: */
%token END ENDL

/* Define terminal symbols: */
%token <ival> INT;
%token <fval> FLOAT;
%token <sval> STRING;
%token <kval> KEYWORD;
%token <oval> OPERATOR;
%token <doval> DOUBLE_OPERATOR;
%%
c_legacy:

	c_legacy KEYWORD STRING SPECIAL_SYMBOL KEYWORD SPECIAL_SYMBOL {printf("Bison found a method: %s\n", $3);}
	| c_legacy KEYWORD STRING SPECIAL_SYMBOL INT {printf("Bison found a variable definition: %s %d \n", $2, $5);}
	| c_legacy KEYWORD STRING SPECIAL_SYMBOL FLOAT {printf("Bison found a variable definition: %s %lf \n", $2, $5);}
	| c_legacy INT {printf("Bison found an int: %d\n", $2);}
	| c_legacy FLOAT {printf("Bison found a float: %f\n", $2);}
	| c_legacy STRING {printf("Bison found a string: %s\n", $2);}
	| c_legacy KEYWORD {printf("Bison found a keyword: %s\n", $2);}
	| c_legacy SPECIAL_SYMBOL {printf("Bison found a special symbol: %d\n", $2);}
	| c_legacy DOUBLE_OPERATOR {printf("Bison found a double operator: %s\n", $2);}
	| KEYWORD STRING SPECIAL_SYMBOL KEYWORD SPECIAL_SYMBOL {printf("Bison found a method: %s\n", $2);}
        | KEYWORD STRING SPECIAL_SYMBOL INT {printf("Bison found a variable definition: %s %d \n", $1, $4);}
        | KEYWORD STRING SPECIAL_SYMBOL FLOAT {printf("Bison found a variable definition: %s %lf \n", $1, $4);}
	| INT {printf("Bison found a float: %d\n", $1);}
	| FLOAT {printf("Bison found a string: %f\n", $1);}
	| STRING {printf("Bison found a string: %s\n", $1);}
	| KEYWORD {printf("Bison found a keyword: %s\n", $1);}
	| SPECIAL_SYMBOL {printf("Bison found a special symbol: %d\n", $1);}
	| DOUBLE_OPERATOR {printf("Bison found a double operator: %s\n", $1);}
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

