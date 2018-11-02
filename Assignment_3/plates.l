
%{
	char temp[2];
	int year = 0;
%}


%%

[0-9]{3}-(C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|T|W|WH|WX|WW)-[0-9]{1,6}  {   								 strncpy(temp, yytext, 2);
									 
									 year = atoi(temp)+2000;
									 if(year >= 2013) { 
									 	printf("%d\n", 2018-year);
									 }
									 else printf("INVALID\n");
}

[0-9]{2}-(C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LK|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|TN|TS|W|WD|WH|WX|WW)-[0-9]{1,6}  {   					 strncpy(temp, yytext, 2);
								     year = atoi(temp);
									 if(year >= 0 && year <= 12) { year += 2000; 												printf("%d\n", 2018-year); 
									 }
									 else if(year <= 99 && year >= 87) { year += 1900; 												printf("%d\n", 2018-year); 
									 }
									 else printf("INVALID\n"); 
}

[0-9]*-*[a-zA-z]*-*[0-9]*			 { printf("INVALID\n"); }

.					  				 { }

\n					  				 { }

%%

int main()
{
	yylex();
	return 0;
}

