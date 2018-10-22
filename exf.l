%{
#include "exf.h"
#include "exf.tab.h"
%}
%%
[=();!*+&#{}]	{return(yytext[0]);}
"bin"		{yylval.t = 'B';return(BIN);}
"hex"		{yylval.t = 'H';return(HEX);}
[01]+		{yylval.typeexpr.place = strdup(yytext); 
         	yylval.typeexpr.ival = atoi(yytext);return(BITCONST);}
"0"[xX][0-9A-Fa-f]+	{yylval.typeexpr.place = strdup(yytext); 
         	yylval.typeexpr.ival = atoi(yytext);return(HEXCONST);}
[A-Za-z][A-Za-z0-9_]*	{yylval.typeexpr.place = strdup(yytext);yylval.s = strdup(yytext);return(ID);}
\n		{return(0);}
" "		{ }
.		{ }
%%
