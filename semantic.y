%{
#include "semantic.h"
%}


%union    {
  struct example typeexpr;
  double d;
  char *s;
  char t;
}

%token <d> INTCONST DOUCONST
%token <s> IDENT
%token <t> DOUBLE INT
%type <typeexpr> expr
%type <typeexpr> decll
%type <t> tipo

%left '+'
%left '*'

%%
start : decll expr {printf("The type of the result is: %c\n",$2.type);}
      ;

decll : decll decl 
	| decl {}
	;
decl : tipo IDENT ';' {if(!find($2)) {place=lookup($2); place->type=$1;}
                       else {printf("Duplicated declaration %s\n", $2);
                             exit(0);}}

tipo : DOUBLE {$$ ='D';} 
     | INT {$$ = 'I';}
     ;

expr : expr '+' expr {if($1.type == $3.type) $$.type = $1.type;
			else yyerror("Type mismatch");} 
     | expr '*' expr {if($1.type == $3.type) $$.type = $1.type;
			else yyerror("Type mismatch");}
     | '(' expr ')' {$$.type = $2.type;}
     | INTCONST {$$.type = 'I';}
     | DOUCONST {$$.type = 'D';} 
     | IDENT {if(find($1)) {place=lookup($1); $$.type=place->type;}
                       else {printf("Identifier not declared %s\n", $1); exit(0);}}
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

