/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_BISON_OUT_SYNT_TAB_H_INCLUDED
# define YY_YY_BISON_OUT_SYNT_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    IDENTIFIER = 258,              /* IDENTIFIER  */
    INTEGER = 259,                 /* INTEGER  */
    CONSTANT_INTEGER = 260,        /* CONSTANT_INTEGER  */
    CONSTANT_FLOAT = 261,          /* CONSTANT_FLOAT  */
    CONSTANT_CHAR = 262,           /* CONSTANT_CHAR  */
    DOUBLE = 263,                  /* DOUBLE  */
    KEY_WORD_IF = 264,             /* KEY_WORD_IF  */
    KEY_WORD_ELSE = 265,           /* KEY_WORD_ELSE  */
    KEY_WORD_WHILE = 266,          /* KEY_WORD_WHILE  */
    KEY_WORD_FOR = 267,            /* KEY_WORD_FOR  */
    KEY_WORD_INT = 268,            /* KEY_WORD_INT  */
    KEY_WORD_FLOAT = 269,          /* KEY_WORD_FLOAT  */
    KEY_WORD_CHAR = 270,           /* KEY_WORD_CHAR  */
    KEY_WORD_DOUBLE = 271,         /* KEY_WORD_DOUBLE  */
    KEY_WORD_VOID = 272,           /* KEY_WORD_VOID  */
    KEY_WORD_RETURN = 273,         /* KEY_WORD_RETURN  */
    KEY_WORD_LOGICAL_AND = 274,    /* KEY_WORD_LOGICAL_AND  */
    KEY_WORD_LOGICAL_OR = 275,     /* KEY_WORD_LOGICAL_OR  */
    KEY_WORD_LOGICAL_NOT = 276,    /* KEY_WORD_LOGICAL_NOT  */
    KEY_WORD_EQUAL = 277,          /* KEY_WORD_EQUAL  */
    KEY_WORD_CEQ = 278,            /* KEY_WORD_CEQ  */
    KEY_WORD_CNE = 279,            /* KEY_WORD_CNE  */
    KEY_WORD_CLT = 280,            /* KEY_WORD_CLT  */
    KEY_WORD_CLE = 281,            /* KEY_WORD_CLE  */
    KEY_WORD_CGT = 282,            /* KEY_WORD_CGT  */
    KEY_WORD_CGE = 283,            /* KEY_WORD_CGE  */
    KEY_WORD_LPAREN = 284,         /* KEY_WORD_LPAREN  */
    KEY_WORD_RPAREN = 285,         /* KEY_WORD_RPAREN  */
    KEY_WORD_LBRACE = 286,         /* KEY_WORD_LBRACE  */
    KEY_WORD_RBRACE = 287,         /* KEY_WORD_RBRACE  */
    KEY_WORD_DOT = 288,            /* KEY_WORD_DOT  */
    KEY_WORD_COMMA = 289,          /* KEY_WORD_COMMA  */
    KEY_WORD_SEMICOLON = 290,      /* KEY_WORD_SEMICOLON  */
    KEY_WORD_PLUS = 291,           /* KEY_WORD_PLUS  */
    KEY_WORD_MINUS = 292,          /* KEY_WORD_MINUS  */
    KEY_WORD_MUL = 293,            /* KEY_WORD_MUL  */
    KEY_WORD_DIV = 294             /* KEY_WORD_DIV  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 11 "synt.y"
 
	int integer;
	float reel;
	char* str;

#line 109 "bison_out/synt.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_BISON_OUT_SYNT_TAB_H_INCLUDED  */
