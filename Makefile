bison -d body.y
flex body.l
gcc body.tab.c lex.yy.c -lfl -o clegacy
