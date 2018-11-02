%{
#include <stdio.h>
#include <stdlib.h>

int yyparse();
void yyerror(char *s);
%}

%token ADD SUB MUL DIV
%token ONE FOUR FIVE NINE TEN FOURTY FIFTY NINETY HUNDRED FOUR_HUNDRED FIVE_HUNDRED 
%token NINE_HUNDRED THOUSAND 
%token EOL

%%
roman_numeral_list: //nothing
 | roman_numeral_list exp EOL { if($2 == 0) printf("Z\n"); else dec_to_roman($2); }
 ;

exp: factor
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 ;

factor: numeral
 | factor MUL numeral { $$ = $1 * $3; }
 | factor DIV numeral { $$ = $1 / $3; }
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

void dec_to_roman(int number)
{
	int flag = 0;	
	if(number < 0) {
		number -= number*2;
		flag = 1;
	}
	if(flag == 1) printf("-");

	while(number > 0) {
		if(number >= 1000) {
			number -= 1000;
			printf("M");
		}
		else if(number >= 900) {
			number -= 900;
			printf("CM");
		}
		else if(number >= 500) {
			number -= 500;
			printf("D");
		}
		else if(number >= 400) {
			number -= 400;
			printf("CD");
		}
		else if(number >= 100) {
			number -= 100;
			printf("C");
		}
		else if(number >= 90) {
			number -= 90;
			printf("XC");
		}
		else if(number >= 50) {
			number -= 50;
			printf("L");
		}
		else if(number >= 40) {
			number -= 40;
			printf("XL");
		}
		else if(number >= 10) {
			number -= 10;
			printf("X");
		}
		else if(number >= 9) {
			number -= 9;
			printf("IX");
		}
		else if(number >= 5) {
			number -= 5;
			printf("V");
		}
		else if(number >= 4) {
			number -= 4;
			printf("IV");
		}
		else if(number >= 1) {
			number -= 1;
			printf("I");
		}
	}
	printf("\n");
}	

void yyerror(char *s)
{
	fprintf(stderr, "%s", s);
	exit(0);
}

int main()
{
  yyparse();
  return 0;
}


