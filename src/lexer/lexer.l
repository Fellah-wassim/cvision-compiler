%option noyywrap

%{
  #include<stdio.h>
  #include<stdlib.h>
  #include<string.h>
  #include "../bison/synt.tab.h"
  #include "../../src/symbol-table/symbol-table.h"
  int number_of_lines = 1;
  int column_position = 1;
%}


NUMBER [0-9]
IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*
CHAR (\'[^']*\')
STRING_LITERAL (\"[^\"]*\")
FLOAT {NUMBER}+\.{NUMBER}+
INTEGER {NUMBER}+

%%

{FLOAT} {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng;  
  symbol_table_insert(yytext, "FLOAT", "Variable", atof(yytext));
  return FLOAT; 
}

{INTEGER} {
  if(atoi(yytext) > -32768 && atoi(yytext) < 32768){
    yylval.str = strdup(yytext);
    column_position = column_position + yyleng;
    symbol_table_insert(yytext, "INTEGER", "Variable", atoi(yytext));
    return INTEGER;
  }else{
    printf("Integer invalid at line: %d, column: %d\n", number_of_lines, column_position);
  }
}

{CHAR} {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng;
  symbol_table_insert(yytext, "CHAR", "Variable", 0); // Assuming char literals have no default value
  return CHAR;
}

{STRING_LITERAL} {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng;
  symbol_table_insert(yytext, "STRING_LITERAL", "Variable", 0); // Assuming string literals have no default value
  return STRING_LITERAL;
}

"if" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng;
  symbol_table_insert(yytext, "IF", "Keyword", 0);
  return IF;
}

"else" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng;
  symbol_table_insert(yytext, "ELSE", "Keyword", 0);
  return ELSE;
}

"while" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng;
  symbol_table_insert(yytext, "WHILE", "Keyword", 0);
  return WHILE;
}

"for" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng;
  symbol_table_insert(yytext, "FOR", "Keyword", 0);
  return FOR;
}

"int" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng;
  symbol_table_insert(yytext, "INT", "Keyword", 0);
  return KEY_WORD_INT;
}

"float" {
  yylval.str = strdup(yytext); 
  column_position = column_position + yyleng;
  symbol_table_insert(yytext, "FLOAT", "Keyword", 0);
  return KEY_WORD_FLOAT; 
}

"char" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "CHAR", "Keyword", 0);
  return KEY_WORD_CHAR; 
}

"double" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "DOUBLE", "Keyword", 0);
  return KEY_WORD_DOUBLE; 
}

"const" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "CONST", "Keyword", 0);
  return KEY_WORD_CONST; 
}

"void" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "VOID", "Keyword", 0);
  return VOID; 
}

"return" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "RETURN", "Keyword", 0);
  return RETURN; 
}

"&&" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "&&", "Operator", 0);
  return LOGICAL_AND; 
}

"&" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "&", "Operator", 0);
  return AND; 
}

"||" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "||", "Operator", 0);
  return LOGICAL_OR; 
}

"!" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "!", "Operator", 0);
  return LOGICAL_NOT; 
}

"=" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "=", "Operator", 0);
  return ASSIGN; 
}

"==" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "==", "Operator", 0);
  return EQUAL; 
}

"!=" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "!=", "Operator", 0);
  return NOT_EQUAL; 
}

"<" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "<", "Operator", 0);
  return LOWER; 
}

"<=" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "<=", "Operator", 0);
  return LOWER_OR_EQUAL; 
}

">" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, ">", "Operator", 0);
  return GREATER; 
}

">=" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, ">=", "Operator", 0);
  return GREATER_OR_EQUAL; 
}

"(" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "(", "Separator", 0);
  return LPAREN; 
}

")" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, ")", "Separator", 0);
  return RPAREN; 
}

"{" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "{", "Separator", 0);
  return LBRACE; 
}

"}" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "}", "Separator", 0);
  return RBRACE; 
}

"." {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, ".", "Separator", 0);
  return DOT; 
}

"," {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, ",", "Separator", 0);
  return COMMA; 
}

";" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, ";", "Separator", 0);
  return SEMICOLON; 
}

"+" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "+", "Operator", 0);
  return PLUS; 
}

"-" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "-", "Operator", 0);
  return MINUS; 
}

"*" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "*", "Operator", 0);
  return MUL; 
}

"/" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "/", "Operator", 0);
  return DIV; 
}

"#include".* {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "#include", "Preprocessor Directive", 0);
  return INCLUDE_DIRECTIVE; 
}

"cv::Mat" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "cv::Mat", "Class", 0);
  return CV_MAT; 
}

"cv::"{IDENTIFIER} {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  char cvText[200];
  snprintf(cvText, sizeof(cvText), "cv::%s", yytext);
  symbol_table_insert(yytext, cvText, "Function", 0);
  return CV_FUNCTION; 
}

"cv::Mat::"{IDENTIFIER} {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  char cvMatText[200];
  snprintf(cvMatText, sizeof(cvMatText), "cv::Mat::%s", yytext);
  symbol_table_insert(yytext, cvMatText, "Method", 0);
  return CV_MAT_FUNCTION; 
}

"std::cout" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "std::cout", "Object", 0);
  return STD_COUT;   
}

"std::cerr" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "std::cerr", "Object", 0);
  return STD_CERR;   
}

"std::endl" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "std::endl", "Object", 0);
  return STD_ENDL;   
}

"std::cin" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "std::cin", "Object", 0);
  return STD_CIN;   
}

"std::clog" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "std::clog", "Object", 0);
  return STD_CLOG;   
}

"<uchar>" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "<uchar>", "Type", 0);
  return UCHAR;   
}

\n { 
  number_of_lines++;
  column_position = 0;
}

[ \t] {
  column_position += 2;
}

\/\/[^\n]*
\/\*[^*]*\*\/

{IDENTIFIER} { 
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  symbol_table_insert(yytext, "IDENTIFIER", "Variable", 0);
  return IDENTIFIER; 
}

. {
  column_position++;
  fprintf(stderr, "Unknown token at line: %d, column: %d\n", number_of_lines, column_position);
  yyterminate(); 
}

%%

int main() {
  init_symbol_table();
  yyparse();
  print_table();
}