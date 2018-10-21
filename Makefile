bison -d bool.y
flex bool.l
gcc bool.tab.c lex.yy.c -lfl -o clegacy
