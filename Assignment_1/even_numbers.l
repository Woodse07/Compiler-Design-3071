%{
	int numOfEven = 0;
	int temp = 0;
%}

%%

[0-9]+ { temp = atoi(yytext); if(temp % 2 == 0) numOfEven++; }
\n {}
.  {}

%%

int main()
{
	yylex();
	printf("%d\n", numOfEven);
	return 0;
}
