%{
#include "exf.h"
#include <stdio.h>
#include <stdlib.h>
int ntemp = 0;
int mquad = 0;
%}

%union    {
        struct example typeexpr;
	double d;
	char *s;
        char t;
        }

%token <t>BIN <t>HEX <typeexpr>BITCONST <typeexpr>HEXCONST <typeexpr><s>ID

%type <typeexpr> expr
%type <typeexpr> instrasig
%type <typeexpr> decl

%left '!'
%left '*' '&'
%left '+' '#'

%%
programa	:decl1 bloqueinstr
		;
decl1		:decl1 decl
		|
		;
decl		:BIN ID ';'{if(!find($2)) {place=lookup($2); place->type=$1;}else {printf("Ya ha declarado este identificador, lo duplicó %s\n",$2);
}}
		|HEX ID ';'{if(!find($2)) {place=lookup($2); place->type=$1;}else {printf("Ya ha declarado este identificador, lo duplicó %s\n",$2);
}}
		;
bloqueinstr	:'{'instrasig1'}'
		;
instrasig1	:instrasig1 instrasig
		|
		;
instrasig	:ID '=' expr';'	{if(!find($1))printf("Este identificador no fue declarado %s\n",$1);else{loc=lookup($1);if(loc->type==$3.type){$$.type=$3.type;$$.place = strdup(newtemp());emit("->", $1, $3.place, $$.place);}else yyerror("error de incompatibilidad");}}
		;
expr		:expr '*' expr	{if($1.type == $3.type) $$.type = $1.type;else yyerror("error de incompatibilidad");$$.place = strdup(newtemp());emit("*", $1.place, $3.place, $$.place);}
		|expr '+' expr	{if($1.type == $3.type) $$.type = $1.type;else yyerror("error de incompatibilidad");$$.place = strdup(newtemp());emit("+", $1.place, $3.place, $$.place);}
		|expr '&' expr	{if($1.type == $3.type) $$.type = $1.type;else yyerror("error de incompatibilidad");$$.place = strdup(newtemp());emit("&", $1.place, $3.place, $$.place);}
		|expr '#' expr	{if($1.type == $3.type) $$.type = $1.type;else yyerror("error de incompatibilidad");$$.place = strdup(newtemp());emit("#", $1.place, $3.place, $$.place);}
		|'!' expr	{$$.type=$2.type;}
		|'(' expr ')'	{$$.type=$2.type;}
		|ID		{if(find($1)) {loc=lookup($1); $$.type=loc->type;}else {printf("error de incompatibilidad %s\n", $1);}}
		|BITCONST	{$$.type='B';}
		|HEXCONST	{$$.type='H';}
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
  int scount = NHASH;		/* how many have we looked at */

  while(--scount >= 0) {
    nprobe++;
    if(sp->name && !strcmp(sp->name, sym)) { nold++; return sp; }

    if(!sp->name) {		/* new entry */
      nnew++;
      sp->name = strdup(sym);
      return sp;
    }

    if(++sp >= symtab+NHASH) sp = symtab; /* try the next entry */
  }
  fputs("symbol table overflow\n", stderr);
  abort(); /* tried them all, table is full */

}
char find (char* sym)
{
  struct symbol *sp = &symtab[symhash(sym)%NHASH];
  int scount = NHASH;		/* how many have we looked at */

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
printf("¡Correcto!\n");

printf("ESte es su código intermedio: \n");
for(i=0;i<mquad;i++)
printf("%s %s %s %s \n",quadtab[i].op, quadtab[i].arg1,
quadtab[i].arg2, quadtab[i].res);


}

int yyerror(char *s)
{
fprintf(stderr,"error: %s\n", s);
exit(0);
}
