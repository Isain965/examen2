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
auto {yylval.kval= "auto"; return KEYWORD;}
break {yylval.kval= "break"; return KEYWORD;}
case {yylval.kval= "case"; return KEYWORD;}
char {yylval.kval= "char"; return KEYWORD;}
const {yylval.kval= "const"; return KEYWORD;}
continue {yylval.kval= "continue"; return KEYWORD;}
default {yylval.kval= "default"; return KEYWORD;}
do {yylval.kval= "do"; return KEYWORD;}
double {yylval.kval= "double"; return KEYWORD;}
else {yylval.kval= "else"; return KEYWORD;}
enum {yylval.kval= "enum"; return KEYWORD;}
extern {yylval.kval= "extern"; return KEYWORD;}
float {yylval.kval= "float"; return KEYWORD;}
for {yylval.kval= "for"; return KEYWORD;}
goto {yylval.kval= "goto"; return KEYWORD;}
if {yylval.kval= "if"; return KEYWORD;}
int {yylval.kval= "int"; return KEYWORD;}
long {yylval.kval= "long"; return KEYWORD;}
register {yylval.kval= "register"; return KEYWORD;}
return {yylval.kval= "return"; return KEYWORD;}
short {yylval.kval= "short"; return KEYWORD;}
signed {yylval.kval= "signed"; return KEYWORD;}
sizeof {yylval.kval= "sizeof"; return KEYWORD;}
static {yylval.kval= "static"; return KEYWORD;}
struct {yylval.kval= "struct"; return KEYWORD;}
switch {yylval.kval= "switch"; return KEYWORD;}
typedef {yylval.kval= "typedef"; return KEYWORD;}
union {yylval.kval= "union"; return KEYWORD;}
unsigned {yylval.kval= "unsigned"; return KEYWORD;}
void {yylval.kval= "void"; return KEYWORD;}
volatile {yylval.kval= "volatile"; return KEYWORD;}
while {yylval.kval= "while"; return KEYWORD;}
"!" {yylval.ssval=33; return SPECIAL_SYMBOL; }
"\"" {yylval.ssval=34; return SPECIAL_SYMBOL; }
"#" {yylval.ssval=35; return SPECIAL_SYMBOL; }
"%" {yylval.ssval=37; return SPECIAL_SYMBOL; }
"&?" {yylval.ssval=38; return SPECIAL_SYMBOL; }
"(" {yylval.ssval=40; return SPECIAL_SYMBOL; }
")" {yylval.ssval=41; return SPECIAL_SYMBOL; }
"*" {yylval.ssval=42; return SPECIAL_SYMBOL; }
"+" {yylval.ssval=43; return SPECIAL_SYMBOL; }
"," {yylval.ssval=44; return SPECIAL_SYMBOL; }
"-" {yylval.ssval=45; return SPECIAL_SYMBOL; }
"." {yylval.ssval=46; return SPECIAL_SYMBOL; }
"/" {yylval.ssval=47; return SPECIAL_SYMBOL; }
";" {yylval.ssval=59; return SPECIAL_SYMBOL; }
"<" {yylval.ssval=60; return SPECIAL_SYMBOL; }
"=" {yylval.oval="="; return OPERATOR; }
">" {yylval.ssval=62; return SPECIAL_SYMBOL; }
"\\" {yylval.ssval=92; return SPECIAL_SYMBOL; }
"^" {yylval.ssval=94; return SPECIAL_SYMBOL; }
"_" {yylval.ssval=95; return SPECIAL_SYMBOL; }
"{" {yylval.ssval=123; return SPECIAL_SYMBOL; }
"|" {yylval.ssval=124; return SPECIAL_SYMBOL; }
"}" {yylval.ssval=125; return SPECIAL_SYMBOL; }
"~" {yylval.ssval=126; return SPECIAL_SYMBOL; }
"&&" {yylval.doval = "&&"; return DOUBLE_OPERATOR; }
">=" {yylval.doval = ">="; return DOUBLE_OPERATOR; }
"<=" {yylval.doval = "<="; return DOUBLE_OPERATOR; }
"||" {yylval.doval = "||"; return DOUBLE_OPERATOR; }
"==" {yylval.doval = "=="; return DOUBLE_OPERATOR; }
"++" {yylval.doval = "++"; return DOUBLE_OPERATOR; }
"--" {yylval.doval = "--"; return DOUBLE_OPERATOR; }
[0][xX][0-9a-fA-F]+ {yylval.ival = strtol(yytext, NULL, 16); return INT;}
[0-9]+	{yylval.ival = atoi(yytext); return INT;}
[0-9]+\.[0-9]+ {yylval.fval = atof(yytext); return FLOAT;}
[a-zA-Z0-9]+ {yylval.sval = strdup(yytext); return STRING; }
[[:space:]] { /* DO NOTHING: blank spaces are ignored. */}
"/".*	{ /* DO NOTHING: single -line comments are ignored. */}
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]       { /* DO NOTHING: multi - line commments are ignored */ }
%%
