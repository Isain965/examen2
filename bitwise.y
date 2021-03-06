/**
* A01375997 Isain Cuadra Rivas
* A01376119 Diego Canizales Bollain Goytia
**/

%{
#include "bitwise.h"
#include <stdio.h>
#include <stdlib.h>
int ntemp = 0;
int mquad = 0;
%}

%union {
  struct example typeexpr;
  double d;
  char *s;
  char t;
}

%token <t>BIN <t>HEX <typeexpr>BITCONST <typeexpr>HEXCONST <typeexpr><s>ID

%type <typeexpr> expr
%type <typeexpr> itg
%type <typeexpr> decl

%left '!'
%left '*' '&'
%left '+' '#'

%%
program : decllist blockinstr
          ;

decllist : decllist decl
      |
      ;

decl : BIN ID ';'{if(!find($2)) {place=lookup($2); place->type=$1;}else {printf("Duplicate identifier %s\n",$2);
}}
    | HEX ID ';'{if(!find($2)) {place=lookup($2); place->type=$1;}else {printf("Duplicate identifier %s\n",$2);
}}
    ;

blockinstr : '{'itglist'}'
            ;

itglist : itglist itg
           |
           ;

itg : ID '=' expr';' {if(!find($1))printf("Identifier not defined %s\n",$1); else{loc=lookup($1); if(loc->type==$3.type){$$.type=$3.type;$$.place = strdup(newtemp()); emit("->", $1, $3.place, $$.place);}else yyerror("Incompatible types");}}
          ;

expr : expr '*' expr  {if($1.type == $3.type) $$.type = $1.type;else yyerror("Incompatible data types"); $$.place = strdup(newtemp());emit("*", $1.place, $3.place, $$.place);}
      |expr '+' expr  {if($1.type == $3.type) $$.type = $1.type;else yyerror("Incompatible data types"); $$.place = strdup(newtemp());emit("+", $1.place, $3.place, $$.place);}
      |expr '&' expr  {if($1.type == $3.type) $$.type = $1.type;else yyerror("Incompatible data types"); $$.place = strdup(newtemp());emit("&", $1.place, $3.place, $$.place);}
      |expr '#' expr  {if($1.type == $3.type) $$.type = $1.type;else yyerror("Incompatible data types"); $$.place = strdup(newtemp());emit("#", $1.place, $3.place, $$.place);}
      |'!' expr       {$$.type=$2.type;}
      |'(' expr ')'   {$$.type=$2.type;}
      |ID             {if(find($1)) {loc=lookup($1); $$.type=loc->type;}else {printf("Incompatible data types %s\n", $1);}}
      |BITCONST       {$$.type='B';}
      |HEXCONST       {$$.type='H';}
      ;

%%


static unsigned
symhash(char *sym)
{
  unsigned int hash = 0;
  unsigned c;

  while(c = *sym++) hash = hash*9 ^ c;

  return hash;
}
int nnew, nold;
int nprobe;

struct symbol *
lookup(char* sym)
{
  struct symbol *sp = &symtab[symhash(sym)%NHASH];
  int scount = NHASH;

  while(--scount >= 0) {
    nprobe++;
    if(sp->name && !strcmp(sp->name, sym)) { nold++; return sp; }
    if(!sp->name) {
      nnew++;
      sp->name = strdup(sym);
      return sp;
    }

    if(++sp >= symtab+NHASH) sp = symtab;
  }
  fputs("symbol table overflow\n", stderr); 
  abort();
}

char find (char* sym){
  struct symbol *sp = &symtab[symhash(sym)%NHASH];
  int scount = NHASH;

  while(--scount >= 0)
    if(sp->name && !strcmp(sp->name, sym)) return 1;
  return 0;

}
char * newtemp (void)
{
char temp[10];
sprintf(temp,"t%d",ntemp++);
return strdup(temp);
}
void emit(char *op, char *arg1, char *arg2, char *res)
{
quadtab[mquad].op=strdup(op);
quadtab[mquad].arg1=strdup(arg1);
quadtab[mquad].arg2=strdup(arg2);
quadtab[mquad].res=strdup(res);
mquad++;
}
  
int main(int argc, char **argv)
{
int i;
yyparse();
printf("The inserted code is correct!\n");

printf("This is their intermediate code: \n");
for(i=0;i<mquad;i++)
printf("%s %s %s %s \n",quadtab[i].op, quadtab[i].arg1,
quadtab[i].arg2, quadtab[i].res);
}

int yyerror(char *s)
{
fprintf(stderr,"error: %s\n", s);
exit(0);
}