/* Headers - Declarations - Definitions*/
%{
#include "calcu.tab.h"
%}

/* RE definitions */
digit   [0-9]
number  {digit}+("."{digit}+)?

/* Token detection with RE */
%%
{number}    { yylval.fval = atof(yytext); return NUMBER; }
"+"         { return SUM;     }
"-"         { return SUB;     }
"*"         { return MULT;    }
"/"         { return DIV;     }
"|"         { return ABS;     }
"\n"        { return ENDLINE; }
[ \t]+      {}
.           {}
%%