%{
	int count = 0; 
%}

%%

(^o|X$|[A-Z]+$) { count++; printf("%d\n", count); }

%%

int main()
{
	yylex();
	printf("Counted: %d\n", count);
	return 0;
}


// Q1. 20
// Q2. 4
// Q3. 7
// Q4. 12
// Q5. 9
// Q6. 20
// Q7. 23
// Q8. 6
// Q9. 7
// Q10. 0?
