
%option yylineno
    int lineno = 1;

Keyword     int|char|float|double|return|if|else|while|break|for|print
Operator    =|!|\+|-|\*|\/|==|!=|<|>|<=|>=|&&|\|\|
SpSymbol    \[|\]|\(|\)|\{|\}|;|,
Identifier  id([A-Z][a-z]*)?
Number      [3-6]+
Char        '[.|\\n|\\t| ]'
Comment     \/\/

%x Error
%%
{Keyword}       {
                    yylval.key_val = yytext;
                    ECHO;
                }

{Operator}      {
                    yylval.op_val = yytext;
                    ECHO;
                }
{SpSymbol}      {
                    ECHO;
                }
{Identifier}    {
                    return ID;
                }
{Number}        {
                   yylval.num_val = atoi(yytext); 
                   return NUM; 
                }
{Char}          printf("\t<Char>            %s\n", yytext);
(\n|\r\n)       printf("Line %d\n", yylineno);
[ \t]+      ;
{Comment}       {
                    char c;
                    while((c = input()) != '\n')
                        ;
                    unput(c);
                }
.               {
                    yyerror();
                    exit(1);
                }

%%

