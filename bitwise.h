#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct  example  {
        char type;
        double val;
        double dval;
        int ival;
        char *place;
        };

struct symbol {
    char type;
    char *name;
  };

struct quadruple {
        char *op;
        char *arg1;
        char *arg2;
        char *res;
        };

#define NHASH 9997
  struct symbol symtab[NHASH];

  char find(char*);

#define NQUAD 1000
  struct quadruple quadtab[NQUAD];

  struct symbol *lookup(char*);

struct symbol *place;

int yyerror(char *);

int yylex();

struct symbol *loc;

void emit(char *, char *, char *, char *);
char* newtemp(void);  
