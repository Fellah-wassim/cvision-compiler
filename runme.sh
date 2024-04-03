flex lexer.l
bison -d synt.y
gcc -o steemit synt.tab.c lex.yy.c 
