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

#ifndef YY_YY_OUT_BISON_SYNT_TAB_H_INCLUDED
# define YY_YY_OUT_BISON_SYNT_TAB_H_INCLUDED
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
    KEY_WORD_CONST = 260,          /* KEY_WORD_CONST  */
    CONSTANT_INTEGER = 261,        /* CONSTANT_INTEGER  */
    CONSTANT_FLOAT = 262,          /* CONSTANT_FLOAT  */
    CONSTANT_CHAR = 263,           /* CONSTANT_CHAR  */
    DOUBLE = 264,                  /* DOUBLE  */
    IF = 265,                      /* IF  */
    ELSE = 266,                    /* ELSE  */
    WHILE = 267,                   /* WHILE  */
    FOR = 268,                     /* FOR  */
    KEY_WORD_INT = 269,            /* KEY_WORD_INT  */
    KEY_WORD_FLOAT = 270,          /* KEY_WORD_FLOAT  */
    KEY_WORD_CHAR = 271,           /* KEY_WORD_CHAR  */
    KEY_WORD_DOUBLE = 272,         /* KEY_WORD_DOUBLE  */
    VOID = 273,                    /* VOID  */
    RETURN = 274,                  /* RETURN  */
    LOGICAL_AND = 275,             /* LOGICAL_AND  */
    AND = 276,                     /* AND  */
    LOGICAL_OR = 277,              /* LOGICAL_OR  */
    LOGICAL_NOT = 278,             /* LOGICAL_NOT  */
    ASSIGN = 279,                  /* ASSIGN  */
    EQUAL = 280,                   /* EQUAL  */
    NOT_EQUAL = 281,               /* NOT_EQUAL  */
    LOWER = 282,                   /* LOWER  */
    LOWER_OR_EQUAL = 283,          /* LOWER_OR_EQUAL  */
    GREATER = 284,                 /* GREATER  */
    GREATER_OR_EQUAL = 285,        /* GREATER_OR_EQUAL  */
    LPAREN = 286,                  /* LPAREN  */
    RPAREN = 287,                  /* RPAREN  */
    LBRACE = 288,                  /* LBRACE  */
    RBRACE = 289,                  /* RBRACE  */
    DOT = 290,                     /* DOT  */
    COMMA = 291,                   /* COMMA  */
    SEMICOLON = 292,               /* SEMICOLON  */
    PLUS = 293,                    /* PLUS  */
    MINUS = 294,                   /* MINUS  */
    MUL = 295,                     /* MUL  */
    DIV = 296,                     /* DIV  */
    INCLUDE_DIRECTIVE = 297,       /* INCLUDE_DIRECTIVE  */
    STRING_LITERAL = 298,          /* STRING_LITERAL  */
    CV_MAT = 299,                  /* CV_MAT  */
    CV_FUNCTION = 300,             /* CV_FUNCTION  */
    CV_MAT_FUNCTION = 301          /* CV_MAT_FUNCTION  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 11 "src/parser/parser.y"
 
	int integer;
	float reel;
	char* str;

#line 116 "out/bison/synt.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_OUT_BISON_SYNT_TAB_H_INCLUDED  */
