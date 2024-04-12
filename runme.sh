if [[ ! -d "out" ]]; then
  mkdir -p out/flex out/bison
fi

bison -d -o out/bison/synt.tab.c src/parser/parser.y
flex -o out/flex/lex.yy.c src/lexer/lexer.l
gcc -o out/cvision out/bison/synt.tab.c out/flex/lex.yy.c 
./out/cvision < tests/ex.cpp