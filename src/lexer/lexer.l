%option noyywrap

%{
  #include<stdio.h>
  #include<stdlib.h>
  #include<string.h>
  #include "../bison/synt.tab.h"
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
  return FLOAT; 
}

{INTEGER} {
  if(atoi(yytext) > -32768 && atoi(yytext) < 32768){
    yylval.str = strdup(yytext);
    column_position = column_position + yyleng;
    return INTEGER;
  }else{
    printf("Integer invalide line: %d, column: %d", number_of_lines, column_position);
  }
}

{CHAR} {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng;
  return CHAR;
}

{STRING_LITERAL} {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng;
  return STRING_LITERAL;
}

"if" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng;
  return IF;
}

"else" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng;
  return ELSE;
}

"while" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng;
  return WHILE;
}

"for" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng;
  return FOR;
}

"int" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng;
  return KEY_WORD_INT;
}

"float" {
  yylval.str = strdup(yytext); 
  column_position = column_position + yyleng;
  return KEY_WORD_FLOAT; 
}

"char" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return KEY_WORD_CHAR; 
}

"double" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return KEY_WORD_DOUBLE; 
}

"const" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return KEY_WORD_CONST; 
}

"void" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return VOID; 
}

"return" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return RETURN; 
}

"&&" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return LOGICAL_AND; 
}

"&" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return AND; 
}

"||" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return LOGICAL_OR; 
}

"!" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return LOGICAL_NOT; 
}

"=" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return ASSIGN; 
}

"==" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return EQUAL; 
}

"!=" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return NOT_EQUAL; 
}

"<" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return LOWER; 
}

"<=" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return LOWER_OR_EQUAL; 
}

">" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return GREATER; 
}

">=" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return GREATER_OR_EQUAL; 
}

"(" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return LPAREN; 
}

")" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return RPAREN; 
}

"{" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return LBRACE; 
}

"}" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return RBRACE; 
}

"." {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return DOT; 
}

"," {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return COMMA; 
}

";" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return SEMICOLON; 
}

"+" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return PLUS; 
}

"-" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return MINUS; 
}

"*" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return MUL; 
}

"/" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return DIV; 
}

"#include".* {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return INCLUDE_DIRECTIVE; 
}

"cv::Mat" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return CV_MAT; 
}

"cv::"{IDENTIFIER} {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return CV_FUNCTION; 
}

"cv::Mat::"{IDENTIFIER} {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return CV_MAT_FUNCTION; 
}

"std::cout" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return STD_COUT;   
}

"std::cerr" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return STD_CERR;   
}

"std::endl" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return STD_ENDL;   
}

"std::cin" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return STD_CIN;   
}

"std::clog" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
  return STD_CLOG;   
}

"<uchar>" {
  yylval.str = strdup(yytext);
  column_position = column_position + yyleng; 
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
  return IDENTIFIER; 
}

. {
  column_position++;
  fprintf(stderr, "Unknown token at line: %d, column: %d\n", number_of_lines, column_position);
  yyterminate(); 
}

%%