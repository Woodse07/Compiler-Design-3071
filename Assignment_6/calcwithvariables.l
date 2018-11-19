
%{
# include "calcwithvariables.tab.h"
void yyerror(char *s);
%}

%%
"+"	{ return ADD; }
"-"	{ return SUB; }
"*"	{ return MUL; }
"/"	{ return DIV; }
"|"     { return ABS; }
[0-9]	{ yylval = atoi(yytext); return NUMBER; }

[a-z] 	{ yylval = yytext[0]; return VAR; }
":="	{ return ASSIGN; }
";"		{ return FINCOMMAND; }
"print" { return PRINT; }

\n      { /* ignore new lines */ }
[ \t]   { /* ignore white space */ }
.	{ yyerror("syntax error");}
%%
