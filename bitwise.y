%{
#include <stdio.h>
#include <stdlib.h>
int yyerror(char *);
int yylex();
%}

%token hex bin hexconst binconst identifier
%left '+'
%left '*'
%left '!'


%%

prog : decllist instrblock;


decl : type identifier;
     
type : bin | hex;

decllist : decllist decl
          | 
          ;

instrblock : '{'instrlist'}'
          ;

instrlist : instrlist assigninstr
          | 
          ;


assigninstr : identifier '=' expr ';' 
            ;


expr : expr '+' expr
     | expr '*' expr
     | expr '&' expr
     | expr '#' expr
     | '!' expr
     | '(' expr ')'
     | hex
     | bin
     | identifier
     ;


%%

int main(int argc, char **argv)
{
yyparse();
printf("Expresion aceptada \n");
}

int yyerror(char *s)
{
fprintf(stderr,"error: %s\n", s);
exit(0);
}
