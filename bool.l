%{
#include "bool.tab.h"
%}

%%
[01]	{return(BOOLCONST);}
"bool"  {return(BOOL);}
[a-zA-Z][a-zA-Z_]* {return(IDENT);}
"->"    {return(IMP);}
[=+*();{}!]	{return(yytext[0]);}
\n	{return(0);}
. 	{ }
%%
