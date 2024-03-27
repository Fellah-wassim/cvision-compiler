%{
#include <string>
#define SAVE_TOKEN yylval.string = new std::string(yytext, yyleng)
#define TOKEN(t) (yylval.token = t)
extern "C" int yywrap() { }
%}

%%


[ \t\n\r]               ; // Ignore whitespace and newlines
\/\/[^\n]*              ; // Ignore single-line comments
\/\*[^*]*\*\/           ; // Ignore multi-line comments
[a-zA-Z_][a-zA-Z0-9_]*  SAVE_TOKEN; return TIDENTIFIER;
[0-9]+.[0-9]*           SAVE_TOKEN; return TDOUBLE;
[0-9]+                  SAVE_TOKEN; return TINTEGER;
"if"                    return TOKEN(TIF);
"else"                  return TOKEN(TELSE);
"while"                 return TOKEN(TWHILE);
"for"                   return TOKEN(TFOR);
"int"                   return TOKEN(TINT);
"float"                 return TOKEN(TFLOAT);
"char"                  return TOKEN(TCHAR);
"double"                return TOKEN(TDOUBLE);
"void"                  return TOKEN(TVOID);
"return"                return TOKEN(TRETURN);
"&&"                    return TOKEN(TLOGICAL_AND);
"||"                    return TOKEN(TLOGICAL_OR);
"!"                     return TOKEN(TLOGICAL_NOT);
"="                     return TOKEN(TEQUAL);
"=="                    return TOKEN(TCEQ);
"!="                    return TOKEN(TCNE);
"<"                     return TOKEN(TCLT);
"<="                    return TOKEN(TCLE);
">"                     return TOKEN(TCGT);
">="                    return TOKEN(TCGE);
"("                     return TOKEN(TLPAREN);
")"                     return TOKEN(TRPAREN);
"{"                     return TOKEN(TLBRACE);
"}"                     return TOKEN(TRBRACE);
"."                     return TOKEN(TDOT);
","                     return TOKEN(TCOMMA);
";"                     return TOKEN(TSEMICOLON);
"+"                     return TOKEN(TPLUS);
"-"                     return TOKEN(TMINUS);
"*"                     return TOKEN(TMUL);
"/"                     return TOKEN(TDIV);
.                       printf("Unknown token!n"); yyterminate();

%%
