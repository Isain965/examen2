#!/bin/bash
bison -d bitwise.y
flex bitwise.l
cc lex.yy.c bitwise.tab.c -o analizer -lfl -lm

