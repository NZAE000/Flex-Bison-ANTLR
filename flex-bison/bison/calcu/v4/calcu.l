%{
#include "calcu.tab.h"
#include "symbol_table.h"
#include <string.h>
%}

/* RE definitions */
digit   [0-9]
number  {digit}+("."{digit}+)?

/* Token detection with RE */
%%
{number}               { yylval.fval = atof(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* {
                        yylval.sval = find_symbol(yytext);
                        if (!yylval.sval)
                            yylval.sval = insert_symbol(yytext, 0);
                        return IDENTIFIER;
                    }
"="                 { return ASSIGN; }
"+"                 { return SUM; }
"-"                 { return SUB; }
"*"                 { return MULT; }
"/"                 { return DIV; }
"|"                 { return ABS; }
"\n"                { return ENDLINE; }
[ \t]+              {}
.                   {}
%%
