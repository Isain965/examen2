bison -d clegacy.y
flex clegacy.l
gcc clegacy.tab.c lex.yy.c -lfl -o clegacy
