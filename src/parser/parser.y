%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  extern int number_of_lines, column_position;
  extern int yylex();
  void yyerror();
%}

%union 
{ 
	int integer;
	float reel;
	char* str;
}

%token <str>IDENTIFIER <str>KEY_WORD_CONST <str>INTEGER <str>FLOAT <str>CHAR <str>IF <str>ELSE <str>WHILE 
%token <str>FOR <str>KEY_WORD_INT <str>KEY_WORD_FLOAT <str>KEY_WORD_CHAR <str>KEY_WORD_DOUBLE 
%token <str>VOID <str>RETURN <str>LOGICAL_AND <str>AND <str>LOGICAL_OR 
%token <str>LOGICAL_NOT <str>ASSIGN <str>EQUAL <str>NOT_EQUAL <str>LOWER 
%token <str>LOWER_OR_EQUAL <str>GREATER <str>GREATER_OR_EQUAL <str>LPAREN <str>RPAREN 
%token <str>LBRACE <str>RBRACE <str>DOT <str>COMMA  
%token <str>SEMICOLON <str>PLUS <str>MINUS <str>MUL <str>DIV
%token <str>INCLUDE_DIRECTIVE <str>STRING_LITERAL <str>CV_MAT <str>CV_FUNCTION <str>CV_MAT_FUNCTION

%start program

%%

program: INCLUDE_DIRECTIVE function_definition_list {
  printf("SYNTAX CORRECT \n");
  YYACCEPT;
}

function_definition_list: function_definition
  | function_definition function_definition_list

function_definition: type IDENTIFIER LPAREN parameter_list RPAREN LBRACE statement_list RBRACE

parameter_list: parameter
  | parameter COMMA parameter_list

parameter: type IDENTIFIER
  | function_call
  | predefined_function_call
  | CV_FUNCTION
  | STRING_LITERAL
  | IDENTIFIER
  | /*EMPTY*/

type: KEY_WORD_INT
  | KEY_WORD_FLOAT
  | KEY_WORD_CHAR
  | KEY_WORD_DOUBLE
  | KEY_WORD_CONST
  | CV_MAT
  | KEY_WORD_CONST CV_MAT AND


statement_list: statement
  | statement statement_list

statement: declaration SEMICOLON
  | assignment SEMICOLON
  | CV_FUNCTION LPAREN parameter_list RPAREN SEMICOLON
  | IF LPAREN condition_list RPAREN LBRACE statement_list RBRACE
  | FOR LPAREN assignment SEMICOLON condition SEMICOLON assignment RPAREN LBRACE statement_list RBRACE

condition_list: condition
  | LPAREN condition_list RPAREN
  | condition logical_operator condition_list
  | LOGICAL_NOT condition
  | LOGICAL_NOT condition logical_operator condition_list

condition: item
  | item comparision_operator item

item: IDENTIFIER
  | function_call
  | constant
  | predefined_function_call
  | CV_MAT_FUNCTION

comparision_operator: GREATER
  | GREATER_OR_EQUAL
  | LOWER
  | LOWER_OR_EQUAL
  | EQUAL
  | NOT_EQUAL

logical_operator: LOGICAL_AND
  | LOGICAL_OR

declaration: type IDENTIFIER

assignment: declaration ASSIGN item
  | item ASSIGN item
  | item math_operator math_operator
  | math_operator math_operator item

math_operator: PLUS 
  | MINUS
  | DIV
  | MUL

function_call: IDENTIFIER LPAREN parameter_list RPAREN
  | IDENTIFIER DOT function_call
  | IDENTIFIER DOT IDENTIFIER

predefined_function_call: CV_MAT_FUNCTION LPAREN parameter_list RPAREN
  | CV_FUNCTION LPAREN parameter_list RPAREN

constant: CHAR
  | FLOAT
  | INTEGER

%%

void yyerror ()
{
    printf ("Syntax error in line %d column %d \n", number_of_lines, column_position);
    exit(1);
}

int main (int argc, char *argv[]){
    yyparse();
}
