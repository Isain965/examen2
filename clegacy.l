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
[ \n\t\r]+	{ if(yytext=="\n"){line_num ++; return ENDL;};}
"bin" {yylval.kval = "bin"; return KEYWORD; }
"hex" {yylval.kval = "hex"; return KEYWORD; }
Decl {yylval.kval = "Decl"; return KEYWORD; }
"!" {yylval.oval="!"; return OPERATOR; }
"#" {yylval.oval="#"; return OPERATOR; }
"&" {yylval.oval="&"; return OPERATOR; }
"(" {yylval.oval=yytext; return OPERATOR; }
")" {yylval.oval=")"; return OPERATOR; }
"*" {yylval.oval="*"; return OPERATOR; }
"+" {yylval.oval="+"; return OPERATOR; }
";" {yylval.oval=";"; return OPERATOR; }
"=" {yylval.oval="="; return OPERATOR; }
"{" {yylval.oval="{->}"; return OPERATOR; }
"}" {yylval.oval="{<-}"; return OPERATOR; }
[0][xX][0-9a-fA-F]+ {yylval.ival = strtol(yytext, NULL, 16); return INT;}
[0,1]{8} {yylval.bval = yytext; return BINARY;}
[_a-zA-Z][_a-zA-Z0-9]{0,30} {yylval.sval = yytext; return IDENTIFIER;}
[[:space:]] { /* DO NOTHING: blank spaces are ignored. */}
"/".*	{ /* DO NOTHING: single -line comments are ignored. */}
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]       { /* DO NOTHING: multi - line commments are ignored */ }
%%
