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

%token <str> IDENTIFIER INTEGER FLOAT CHAR VOID RETURN
%token <str> FOR IF ELSE WHILE
%token <str> LOGICAL_AND LOGICAL_NOT LOGICAL_OR AND
%token <str> KEY_WORD_INT KEY_WORD_FLOAT KEY_WORD_CHAR KEY_WORD_DOUBLE KEY_WORD_CONST
%token <str> ASSIGN EQUAL NOT_EQUAL LOWER LOWER_OR_EQUAL GREATER GREATER_OR_EQUAL
%token <str> LPAREN RPAREN LBRACE RBRACE DOT COMMA SEMICOLON
%token <str> PLUS MINUS MUL DIV
%token <str> STD_CERR STD_COUT STD_ENDL STD_CIN STD_CLOG
%token <str> INCLUDE_DIRECTIVE STRING_LITERAL
%token <str> CV_MAT CV_FUNCTION CV_MAT_FUNCTION
%token <str> UCHAR

%start program

%%

program: include function_definition_list {
  printf("SYNTAX CORRECT \n");
  YYACCEPT;
}

include: INCLUDE_DIRECTIVE
  | /*EMPTY*/

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
  | constant
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
  | std_out LOWER LOWER STRING_LITERAL LOWER LOWER STD_ENDL SEMICOLON
  | RETURN condition SEMICOLON

std_out: STD_CERR
  | STD_COUT
  | STD_CIN
  | STD_CLOG

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
  | special_function_call ASSIGN item math_operator special_function_call

math_operator: PLUS 
  | MINUS
  | DIV
  | MUL

function_call: IDENTIFIER LPAREN parameter_list RPAREN
  | IDENTIFIER DOT function_call
  | IDENTIFIER DOT IDENTIFIER

special_function_call: IDENTIFIER DOT IDENTIFIER UCHAR LPAREN parameter_list RPAREN

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
