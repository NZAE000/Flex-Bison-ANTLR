/* Headers - Declarations - Definitions*/
%{
#include "calcu.tab.h"
%}

/* Tokens rules (RE)*/

%%
[0-9]+      { yylval.ival = atoi(yytext); return NUMBER; }
"+"         { strcpy(yylval.strval, yytext); return SUM; }
"-"         { strcpy(yylval.strval, yytext); return SUB; }
"*"         { strcpy(yylval.strval, yytext); return MULT; }
"/"         { strcpy(yylval.strval, yytext); return DIV; }
"|"         { strcpy(yylval.strval, yytext); return ABS; }
"\n"        { return ENDLINE; }
[ \t]+      {}
.           {}
%%