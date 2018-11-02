%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
//int yyparse();
void yyerror(char *s);
%}

%token ONE FIVE TEN FIFTY HUNDRED FIVE_HUNDRED THOUSAND 
%token ABS EOL

%%
roman_numeral: //nothing
 | roman_numeral numeral EOL { printf("%d\n", $2); }
 ;

numeral: term
 | HUNDRED THOUSAND HUNDRED HUNDRED {yyerror("syntax error\n");}
 | ONE FIVE { $$ = 4; }
 | ONE TEN  { $$ = 9; }
 | TEN FIFTY { $$ = 40; } 
 | TEN HUNDRED { $$ = 90; }
 | HUNDRED FIVE_HUNDRED { $$ = 400; }
 | HUNDRED THOUSAND { $$ = 900; }
 | numeral ONE FIVE { if($1 )$$ = $1 + 4; }
 | numeral ONE TEN  { $$ = $1 + 9; }
 | numeral TEN FIFTY { $$ = $1 + 40; } 
 | numeral TEN HUNDRED { $$ = $1 + 90; }
 | numeral HUNDRED FIVE_HUNDRED { $$ = $1 + 400; }
 | numeral HUNDRED THOUSAND { $$ = $1 + 900; }
 | numeral term { $$ = $1 + $2;}
 ;


term:
 | ONE  		{ $$ = 1; }
 | FIVE 		{ $$ = 5; }
 | TEN			{ $$ = 10; }
 | FIFTY 		{ $$ = 50; }
 | HUNDRED		{ $$ = 100; }
 | FIVE_HUNDRED	{ $$ = 500; }
 | THOUSAND		{ $$ = 1000; }
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

