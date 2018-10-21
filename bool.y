%{
#include <stdio.h>
#include <stdlib.h>
int yyerror(char *);
int yylex();
%}

%token BOOLCONST IDENT IMP BOOL
%left IMP
%left '+'
%left '*'
%left '!'

%%

prog : decllist instrblock
     ;


decl : BOOL IDENT ';'
     ;

decllist : decllist decl
          | 
          ;

instrblock : '{' instrlist'}'
          ;

instrlist : instrlist instrassign
          | 
          ;


instrassign : IDENT '=' expr ';' 
            ;


expr : expr '+' expr
     | expr '*' expr
     | expr IMP expr
     | '!' expr
     | '(' expr ')'
     | BOOLCONST
     | IDENT
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

