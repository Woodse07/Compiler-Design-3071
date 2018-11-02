%{
#include "romcalc.tab.h"
void yyerror(char *s);
%}

%%

"{"	  { return LEFT; }
"}"	  { return RIGHT; }
"+"   { return ADD; } 
"-"   { return SUB; } 
"*"   { return MUL; } 
"/"   { return DIV; } 
"I"  { return ONE; }
"IV" { return FOUR; }
"V"  { return FIVE; }
"IX" { return NINE; }
"X"  { return TEN; }
"XL" { return FOURTY; }
"L"  { return FIFTY; }
"XC" { return NINETY; }
"C"  { return HUNDRED; }
"CD" { return FOUR_HUNDRED; }
"D"  { return FIVE_HUNDRED; }
"CM" { return NINE_HUNDRED; }
"M" { return THOUSAND; }
[ \t] {}
\n    { return EOL; }
.	  { yyerror("syntax error\n"); }
%%



