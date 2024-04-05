bison -d -o bison_out/synt.tab.c synt.y
flex -o flex_out/lex.yy.c lexer.l
gcc -o out/cvision bison_out/synt.tab.c flex_out/lex.yy.c 
./out/cvision < examples/ex.txt