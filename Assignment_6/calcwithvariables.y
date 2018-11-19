
%{
#  include <stdio.h>
int yylex();
void yyerror(char *s);
int keyValuePair[1000];
%}


/* declare tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token ASSIGN FINCOMMAND PRINT 
%token VAR

%%
calclist: // nothing
 | calclist assign { $$ = $2; }
 ; 

assign: exp FINCOMMAND
 | PRINT exp FINCOMMAND { printf("%d\n", $2); }
 | VAR ASSIGN exp FINCOMMAND { keyValuePair[$1] = $3; }
 ; 

exp: factor 
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 ;

factor: term 
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { $$ = $1 / $3; }
 ;

term: NUMBER 
 | SUB term { $$ = -$2; }
 | ABS term { $$ = $2 >= 0? $2 : - $2; }
 | VAR { $$ = keyValuePair[$1]; }
 ;
%%
int main()
{
  yyparse();
  return 0;
}

void yyerror(char *s)
{
  fprintf(stderr, "%s\n", s);
}

