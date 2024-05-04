%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "../../src/symbol-table/symbol-table.h"
  #include "../../src/quadruplet/quadruplet.h"
  char stocked_type[20];
  int error = 0;
  char temp [20]; 
	int tempCounter = 1;
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

%type <str> declaration type item function_call constant predefined_function_call special_function_call
%type <str> math_operator

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

function_definition: declaration LPAREN parameter_list RPAREN LBRACE statement_list RBRACE

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

type: KEY_WORD_INT {
    strcpy(stocked_type,"INTEGER");
  }
  | KEY_WORD_FLOAT {
    strcpy(stocked_type,"FLOAT");
  }
  | KEY_WORD_CHAR {
    strcpy(stocked_type,"CHAR");
  }
  | KEY_WORD_DOUBLE {
    strcpy(stocked_type,"DOUBLE");
  }
  | KEY_WORD_CONST {
    strcpy(stocked_type,"CONST");
  }
  | CV_MAT  {
    strcpy(stocked_type,"CVMAT");
  }
  | KEY_WORD_CONST CV_MAT AND {
    strcpy(stocked_type,"CONST_CVMAT_&");
  }


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

item: IDENTIFIER {
    $$ = $1;
  }
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

declaration: type IDENTIFIER {
  if(isDoubleDeclared($2)){
    printf("Semantic error: double declaration of %s, in line %d \n", $2, number_of_lines);
    error=1;
    YYERROR;
  }else{
    symbol_table_insert_type($2, stocked_type);
    $$ = $2;
  }
}

assignment: declaration ASSIGN item {
    element *declaration_identifier = symbol_table_search($1);
    element *item = symbol_table_search($3);
    if(declaration_identifier != NULL && item != NULL){
      if(strcmp(declaration_identifier->type, item->type) != 0 ){
        printf("Semantic error: incompatible types, in line %d \n", number_of_lines);
        error=1;
        YYERROR;
      }
      symbol_table_insert_value($1, item->value);
      quad(":=", $3, "", $1);
    }
  }
  | item ASSIGN item {
    element *item1 = symbol_table_search($1);
    element *item2 = symbol_table_search($3);
    if(item1 != NULL && item2 != NULL){
      if(strcmp(item1->type, item2->type) != 0 ){
        printf("Semantic error: incompatible types, in line %d \n", number_of_lines);
        error=1;
        YYERROR;
      }
      symbol_table_insert_value($1, item2->value);
      quad(":=", $3, "", $1);
    }
  }
  | item math_operator math_operator
  | math_operator math_operator item
  | special_function_call ASSIGN item math_operator special_function_call {
    sprintf(temp,"temp%d",tempCounter);
		tempCounter++;
    quad($4, $3, $5, temp);
    quad(":=", temp, "", $1);
  }

math_operator: PLUS {
    $$ = $1;
  }
  | MINUS {
    $$ = $1;
  }
  | DIV {
    $$ = $1;
  }
  | MUL {
    $$ = $1;
  }

function_call: IDENTIFIER LPAREN parameter_list RPAREN {
    char *str = (char*)malloc(strlen($1) + 3);
    strcpy(str, $1);
    strcat(str, "()");
    $$ = str;
  }
  | IDENTIFIER DOT function_call {
    char *str = (char*)malloc(strlen($1) + strlen($3) + 2);
    strcpy(str, $1);
    strcat(str, ".");
    strcat(str, $3);
    $$ = str;
  }
  | IDENTIFIER DOT IDENTIFIER {
    char *str = (char*)malloc(strlen($1) + strlen($3) + 2);
    strcpy(str, $1);
    strcat(str, ".");
    strcat(str, $3);
    $$ = str;
  }

special_function_call: IDENTIFIER DOT IDENTIFIER UCHAR LPAREN parameter_list RPAREN {
  size_t len = strlen($1) + strlen($2) + strlen($3) + strlen($4) + strlen($5) + strlen($7) + 8;
  char *rule = malloc(len + 1);
  if (rule != NULL) {
    strcpy(rule, $1);
    strcat(rule, $2);
    strcat(rule, $3);
    strcat(rule, $4);
    strcat(rule, $5);
    strcat(rule, $7);
    $$ = rule;
  } else {
    fprintf(stderr, "Memory allocation failed.\n");
    $$ = NULL;
  }
}
predefined_function_call: CV_MAT_FUNCTION LPAREN parameter_list RPAREN
  | CV_FUNCTION LPAREN parameter_list RPAREN

constant: CHAR {
    strcpy(stocked_type,"char");
    $$ = $1;  
  } 
  | FLOAT {
    strcpy(stocked_type,"float");
    $$ = $1; 
  }
  | INTEGER {
    strcpy(stocked_type,"float");
    $$ = $1; 
  }

%%

void yyerror ()
{
  printf ("Syntax error in line %d column %d \n", number_of_lines, column_position);
  exit(1);
}
