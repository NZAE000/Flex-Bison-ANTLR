/* Headers - Declarations - Definitions*/
%{
#include "calcu.tab.h"
%}

/* Tokens rules (RE)*/

%%
[0-9]+      { yylval.fval = atoi(yytext); return NUMBER; }
"+"         { return SUM; }
"-"         { return SUB; }
"*"         { return MULT; }
"/"         { return DIV; }
"|"         { return ABS; }
"\n"        { return ENDLINE; }
[ \t]+      {}
.           {}
%%