%{
	int bracketCount = 0; 
%}


%%

[a-zA-z0-9:=;.()]*	{ if(bracketCount == 0) printf("%s", yytext); }	//any word or digit
\n				{ if(bracketCount == 0) printf("%s", yytext); }	//new line
"**".*			{ /* Print nothing here*/ }					//For ** comments
"{"				{ if(bracketCount == 0) bracketCount++; }
"}"				{ if(bracketCount == 1) bracketCount--; else {printf("syntax error\n"); return 0;} }
\".*\" 			{ printf("%s", yytext);}
.				{ if(bracketCount == 0) printf("%s", yytext); }


%%

int main()
{
	yylex();
	if(bracketCount != 0) {
		printf("syntax error\n");
	}
	return 0;
}


