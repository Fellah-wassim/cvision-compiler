%option noyywrap

%{
  #include<stdio.h>
  #include<stdlib.h>
  #include<string.h>
  #include "synt.tab.h"
  int number_of_line = 1;
  int column_position = 1;
%}


LETTER [a-zA-Z]
NUMBER [0-9]
IDENTIFIER {LETTER}({LETTER}|{NUMBER})*
CONSTANT_INTEGER ({NUMBER}+|"\("[+-]{NUMBER}+"\)")
CONSTANT_FLOAT ({NUMBER}+"."{NUMBER}+|\([+-]{NUMBER}+"."{NUMBER}+\))
CONSTANT_CHAR (\'[^']*\')
DOUBLE {NUMBER}+\.{NUMBER}+
INTEGER {NUMBER}+

%%


{IDENTIFIER} { 
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return IDENTIFIER; 
}

{DOUBLE} {
  yylval.str = strdup(yytext);
  column_position = column_position + strlen(yytext);  
  return DOUBLE; 
}

{INTEGER} {
  yylval.str = strdup(yytext);
  column_position = column_position + strlen(yytext);  
  return INTEGER;
}

{CONSTANT_INTEGER} {
  if(atoi(yytext) > -32768 && atoi(yytext) < 32768){
    yylval.str = strdup(yytext);
    column_position = column_position + strlen(yytext);
    return CONSTANT_INTEGER;
  }else{
    printf("Integer invalide line: %d, column: %d", number_of_line, column_position);
  }
} 

{CONSTANT_FLOAT} {
  yylval.str = strdup(yytext);
  column_position = column_position + strlen(yytext);
  return CONSTANT_FLOAT;
}

{CONSTANT_CHAR} {
  yylval.str = strdup(yytext);
  column_position = column_position + strlen(yytext);
  return CONSTANT_CHAR;
}

"if" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext);
  return KEY_WORD_IF;
}

"else" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext);
  return KEY_WORD_ELSE;
}

"while" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext);
  return KEY_WORD_WHILE;
}

"for" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext);
  return KEY_WORD_FOR;
}

"int" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext);
  return KEY_WORD_INT;
}

"float" {
  yylval.str=strdup(yytext); 
  column_position = column_position + strlen(yytext);
  return KEY_WORD_FLOAT; 
}

"char" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_CHAR; 
}

"double" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_DOUBLE; 
}

"void" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_VOID; 
}

"return" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_RETURN; 
}

"&&" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_LOGICAL_AND; 
}

"||" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_LOGICAL_OR; 
}

"!" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_LOGICAL_NOT; 
}

"=" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_EQUAL; 
}

"==" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_CEQ; 
}

"!=" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_CNE; 
}

"<" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_CLT; 
}

"<=" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_CLE; 
}

">" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_CGT; 
}

">=" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_CGE; 
}

"(" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_LPAREN; 
}

")" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_RPAREN; 
}

"{" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_LBRACE; 
}

"}" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_RBRACE; 
}

"." {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_DOT; 
}

"," {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_COMMA; 
}

";" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_SEMICOLON; 
}

"+" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_PLUS; 
}

"-" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_MINUS; 
}

"*" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_MUL; 
}

"/" {
  yylval.str=strdup(yytext);
  column_position = column_position + strlen(yytext); 
  return KEY_WORD_DIV; 
}

\n                      { number_of_line++; }
[ \t]
\/\/[^\n]*
\/\*[^*]*\*\/ 
.                       { printf("Unknown token!\n"); yyterminate(); }

%%