%{

%}
%union 
{ 
	int integer;
	float reel;
	char* str;
 	struct
	{
		char operation[20]; 
		char operator1[20];   
		char operator2[20];   
		char stocker[20];  
	} quadType; 
}
%token <str>key_word_INTEGER <reel>key_word_FLOAT <str>key_word_CHAR <str>openBracket 
%token <str>key_word_IF <str>key_word_ELSE <str>key_word_FOR <str>key_word_NOT
%token <str>key_word_RANGE <str>key_word_IN <str>key_word_WHILE <str>IDF <str>virgule 
%token <str>key_word_ASSIGNMENT  <str>openSquareBracket <str>closeSquareBracket 
%token <str>closeBracket <str>colon <str>logicalOperand <str>opr_ar <str>opr_ari 
%token <str>comparisionOperand ind <str>newLine <str>CST_INT <str>key_word_BOOL 
%token <str>CST_FLOAT <str>CST_CHAR <str>CST_BOOL comment

%start Start
%nonassoc comparisionOperand newLine    
%right key_word_NOT 
%left opr_ari opr_ar
%type<str> declaration type  ListIDF VALUE opr operand
%type<quadType> expression 
%%

Start : declarationList ListInst 
	{
		printf("Syntax correct \n"); 
		YYACCEPT;
	} 
	| newLines declarationList ListInst
;

declarationList : declaration newLines declarationList
	| declaration newLines 
	| comment newLines declarationList
	| newLines comment declarationList
	| declaration
;

newLines : newLine newLines
	| newLine
;

declaration : type IDF ListIDF
 {	
		if(doubleDeclaration($2)==0)
		{
			insertType($2, stockedType);
		}else
		{	printf("Semantic error: double declaration of %s, in line %d \n",$2,lineNumber-1);
			error=1; 
			YYERROR;
		};
	}
	| type IDF 
	{
		if(doubleDeclaration($2)==0)
		{
			insertType($2, stockedType);
		}else{
			printf("Semantic error: double declaration of %s, in line %d \n",$2,lineNumber-1);
			error=1;
			YYERROR;
		};
	}
	| IDF key_word_ASSIGNMENT VALUE 
	{
		if(strcmp(symbolTable[search($1)].type,symbolTable[search($3)].type)!=0){
			printf("Semantic error: incompatible types, in line %d \n",lineNumber-1);
			error=1;
			YYERROR;
		}
		Quad(":=",$3,"",$1);
		insertValue($1,$3,stockedType);
		insertType($1, stockedType);
	}
	| type IDF openSquareBracket CST_INT closeSquareBracket  
	{
		insertType($1, stockedType);
	}
	| IDF openSquareBracket CST_INT closeSquareBracket key_word_ASSIGNMENT VALUE
	{
		if(strcmp(symbolTable[search($1)].type,symbolTable[search($6)].type)!=0){
			printf("Semantic error: incompatible types, in line %d \n",lineNumber-1);
			error=1;
			YYERROR;
		}
		int position = search($1);
		if(search($1) != -1)
		{
			if(search("[") != -1)
			{
				position = position + 1;
			}else{
				position = position + 2;
			}
			if( atoi(symbolTable[position].name) < atoi($3) )
			{
				printf("Semantic error: the table is declared in size of [%s] you can't index more then that, in line %d \n",symbolTable[position].name,lineNumber-1);
				error=1; 
				YYERROR;
			}
		}
		sprintf(temp,"%s[%s]",$1,$3);
		Quad("=:",temp,"",$6);
	}
	| IDF key_word_ASSIGNMENT expression
	{
		if(strcmp(symbolTable[search($1)].type,$3.stocker)!=0){
			printf("Semantic error: incompatible types, in line %d \n",lineNumber-1);
			error=1;
			YYERROR;
		}
		Quad("=:",$3.stocker,"",$1);
	}
	| IDF openSquareBracket CST_INT closeSquareBracket key_word_ASSIGNMENT expression 
	{
		int position = search($1);
		if(search($1) != -1)
		{
			if(search("[") != -1)
			{
				position = position + 1;
			}else{
				position = position + 2;
			}
			if( atoi(symbolTable[position].name) < atoi($3) )
			{
				printf("Semantic error: the table is declared in size of [%s] you can't index more then that, in line %d \n",symbolTable[position].name,lineNumber-1);
				error=1; 
				YYERROR;
			}
		}
		sprintf(temp,"%s[%s]",$1,$3);
		Quad("=:",temp,"",$6.stocker);
	}
	| IDF openSquareBracket CST_INT closeSquareBracket key_word_ASSIGNMENT IDF 
	{	
		int position = search($1);
		if(search($1) != -1)
		{
			if(search("[") != -1)
			{
				position = position + 1;
			}else{
				position = position + 2;
			}
			if( atoi(symbolTable[position].name) < atoi($3) )
			{
				printf("Semantic error: the table is declared in size of [%s] you can't index more then that, in line %d \n",symbolTable[position].name,lineNumber-1);
				error=1; 
				YYERROR;
			}
		}
		sprintf(temp,"%s[%s]",$1,$3);
		Quad("=:",temp,"",$6);
	}
;

type : key_word_INTEGER {strcpy(stockedType,"int");}
	| key_word_FLOAT {strcpy(stockedType,"float");}
	| key_word_CHAR {strcpy(stockedType,"char");}
	| key_word_BOOL {strcpy(stockedType,"bool");}
;

VALUE : CST_INT {strcpy(stockedType,"int"); strcpy($$,$1);}
  | CST_FLOAT {strcpy(stockedType,"float"); strcpy($$,$1);}
	| CST_CHAR {strcpy(stockedType,"char"); strcpy($$,$1);}
	| CST_BOOL {strcpy(stockedType,"bool"); strcpy($$,$1);}
;

ListIDF : virgule IDF ListIDF
  |	virgule IDF	
	{
		if(doubleDeclaration($1)==0)
		{
			insertType($1, stockedType);
		}else{
			printf("Semantic error: double declaration of %s, in line %d colonne %d \n",$1,lineNumber,col);
			error=1;
			YYERROR;
		};
	}
;

ListInst: instruction newLines ListInst 
	| instruction 
;

instruction : inst_ASSIGNMENT
	| inst_if
	| inst_while
	| inst_for 
;

inst_ASSIGNMENT : IDF key_word_ASSIGNMENT operand {Quad(":=",$3,"",$1);}
	| IDF key_word_ASSIGNMENT expression 	{Quad("=:",$3.stocker,"",$1);}
	| IDF openSquareBracket CST_INT closeSquareBracket  key_word_ASSIGNMENT operand
	{
		sprintf(temp,"%s[%d]",$1,$2);
		Quad("=:",temp,"",$6);
	}
	| IDF openSquareBracket CST_INT closeSquareBracket  key_word_ASSIGNMENT expression
	{
		sprintf(temp,"%s[%s]",$1,$3);
		Quad("=:",temp,"",$6.stocker);
	} 
;
inst_if : key_word_IF openBracket cond closeBracket colon newLine Bloc key_word_ELSE colon newLine Bloc
	| key_word_IF openBracket cond closeBracket colon newLine Bloc 
;

inst_while : key_word_WHILE openBracket cond closeBracket colon newLine Bloc
;

inst_for : for1 
	| for2
;

for1 : key_word_FOR IDF InRange colon newLine Bloc 
;

InRange : key_word_RANGE openBracket VALUE virgule VALUE closeBracket 
	{
		if(atoi($3)>atoi($5))
		{ 
			printf("Semantic error: upper bound lower than the lower bound in line %d colonne %d \n",lineNumber,col);
			error=1;
			YYERROR;
		};
	}
;

for2 : key_word_FOR IDF key_word_IN IDF colon newLine Bloc
;

Bloc: inds instruction newLine Bloc
	| 
;

inds: ind inds
	| ind
;
cond: operand logicalOperand operand
	| operand comparisionOperand operand
	| key_word_NOT operand
	| key_word_NOT openBracket expression closeBracket
;

expression: operand opr expression
	{
		sprintf(temp,"temp%d",tempCounter);
		tempCounter++;
		strcpy($$.stocker,temp);
		strcpy($$.operator2,temp);
		Quad($2,$1,$3.operator2,temp);
		if(strcmp($2,"/")==0){
			printf ("Semantic error: division per 0 in line %d \n",lineNumber-1); error=1; YYERROR;
		};
	}
	| operand opr openBracket expression closeBracket
	{
		sprintf(temp,"temp%d",tempCounter);
		tempCounter++; strcpy($$.stocker,temp);
		Quad($2,$1,$4.stocker,temp);
	}
	| openBracket expression closeBracket
	{
		strcpy($$.stocker,$2.stocker);
	}
	| operand {strcpy($$.operator2,$1);}
;

opr: opr_ar {strcpy($$,$1);}
  | opr_ari {strcpy($$,$1);}
;

operand: VALUE {strcpy($$,$1);}
	| IDF	{strcpy($$,$1);}
	| IDF openSquareBracket CST_INT closeSquareBracket  
;

%%

main()
{
  yyparse();
	if(error==0)
	{
		displaySymbolTable();
		displayQuad();
	} 
	
}
yywrap()
{}
int yyerror ( char*  msg )  
{
	printf ("Syntax error in line %d colonne %d \n", lineNumber,col);
}
