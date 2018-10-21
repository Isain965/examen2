/* Scanner implementation using Flex */
/* recognize tokens and print them out */
/* Functionality:
	* 1.  Ignore blank spaces
	* 2.  Ignore comments
	* 3.  Recognize keywords and return their token category
	* 4.  Recognize delimiters and one-character operators and return their ASCII code as their token category
	* 5.  Recognize two-character operators and return their token category
	* 6.  Recognize  integer,  double,  and  boolean  constants,  and  return  their  token  category
and their value
	* 7.  Recognize identifiers and return their token category.  In addition, if the identifier has not been identified, the identifier must be entered into the symbol table; if the identifier has been already identified, their number of occurrences must be incremented.
	* 8.  Print a generic error message for illegal tokens, indicating the line number where the error occurs.
 	*/

%{
#include "clegacy.tab.h" /* Get the token types from Bison.*/
#include <stdlib.h>
int line_num = 1;
%}

%%
"bin" {printf("found: %s\n", yytext); }
"hex" {printf("found: %s\n", yytext); }
"!" {printf("found: %s\n", yytext); }
"*" {printf("found: %s\n", yytext); }
"+" {printf("found: %s\n", yytext); }
"&" {printf("found: %s\n", yytext); }
"#" {printf("found: %s\n", yytext); }
0[xX][0-9a-fA-F]+ {printf("found a hex number: %s\n", yytext);}
[0,1]{8} {printf("found a binary number: %s\n", yytext);}
[_a-zA-Z][_a-zA-Z0-9]+ {printf("found an identifier: %s\n", yytext);}
[[:space:]] { /* DO NOTHING: blank spaces are ignored. */}
"/".*	{ /* DO NOTHING: single -line comments are ignored. */}
[/][][^][]+([^/][^][]+)[/]       { /* DO NOTHING: multi - line commments are ignored */ }
.	{ printf("ignoring....\n"); }
%%
