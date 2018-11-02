%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
//int yyparse();
void yyerror(char *s);
%}

%token ONE FOUR FIVE NINE TEN FOURTY FIFTY NINETY HUNDRED FOUR_HUNDRED FIVE_HUNDRED 
%token NINE_HUNDRED THOUSAND 
%token EOL

%%
roman_numeral: //nothing
 | roman_numeral numeral EOL { printf("%d\n", $2); }
 ;

numeral: term
 | numeral term { if($2 == 1) {if($1 == 4 || $1 == 9) yyerror("syntax error\n"); else $$ = $1 + $2;}
				  if($2 == 10) {if($1 == 40 || $1 == 90) yyerror("syntax error\n"); else $$ = $1 + $2;}
				  if($2 == 100) {if($1 == 400 || $1 == 900) yyerror("syntax error\n"); else $$ = $1 + $2;}
				  $$ = $1 + $2;		  
				 }
 ;

term:
 | ONE  		{ $$ = 1; }		// I
 | FOUR			{ $$ = 4; }		// IV
 | FIVE 		{ $$ = 5; }		// V
 | NINE			{ $$ = 9; }		// IX
 | TEN			{ $$ = 10; }	// X
 | FOURTY		{ $$ = 40; }	// XL
 | FIFTY 		{ $$ = 50; }	// L
 | NINETY		{ $$ = 90; }	// XC
 | HUNDRED		{ $$ = 100; }	// C
 | FOUR_HUNDRED	{ $$ = 400; }	// CD
 | FIVE_HUNDRED	{ $$ = 500; }	// D
 | NINE_HUNDRED	{ $$ = 900; }	// CM
 | THOUSAND		{ $$ = 1000; }	// M
 ;

%%

int main()
{
  yyparse();
  return 0;
}

void yyerror(char *s)
{
	fprintf(stderr, "%s", s);
	exit(0);
}

