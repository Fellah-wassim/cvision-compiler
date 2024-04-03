%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  extern FILE *yyin;
  extern int yylex();
  void yyerror();
%}

%union 
{ 
	int integer;
	float reel;
	char* str;
}

%token <str>IDENTIFIER <int>INTEGER <str>CONSTANT_INTEGER <str>CONSTANT_FLOAT <str>CONSTANT_CHAR <float>DOUBLE <str>KEY_WORD_IF <str>KEY_WORD_ELSE <str>KEY_WORD_WHILE 
%token <str>KEY_WORD_FOR <str>KEY_WORD_INT <str>KEY_WORD_FLOAT <str>KEY_WORD_CHAR <str>KEY_WORD_DOUBLE 
%token <str>KEY_WORD_VOID <str>KEY_WORD_RETURN <str>KEY_WORD_LOGICAL_AND <str>KEY_WORD_LOGICAL_OR 
%token <str>KEY_WORD_LOGICAL_NOT <str>KEY_WORD_EQUAL <str>KEY_WORD_CEQ <str>KEY_WORD_CNE <str>KEY_WORD_CLT 
%token <str>KEY_WORD_CLE <str>KEY_WORD_CGT <str>KEY_WORD_CGE <str>KEY_WORD_LPAREN <str>KEY_WORD_RPAREN 
%token <str>KEY_WORD_LBRACE <str>KEY_WORD_RBRACE <str>KEY_WORD_DOT <str>KEY_WORD_COMMA  
%token <str>KEY_WORD_SEMICOLON <str>KEY_WORD_PLUS <str>KEY_WORD_MINUS <str>KEY_WORD_MUL <str>KEY_WORD_DIV

%start S

%%

S: IDENTIFIER KEY_WORD_SEMICOLON { printf("Syntax correct %s \n", $1); YYACCEPT; }

%%


void yyerror ()
{
  fprintf(stderr, "Syntax error");
  exit(1);
}

int main (int argc, char *argv[]){

yyparse();

}