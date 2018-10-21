bison -d semantic.y
flex semantic.l
gcc semantic.tab.c lex.yy.c -lfl -o semantic
