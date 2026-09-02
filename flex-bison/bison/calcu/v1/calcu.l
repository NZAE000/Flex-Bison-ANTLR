/* Headers - Declarations - Definitions*/
%{
#include "calcu.tab.h"
%}
/*
                 BISON
                   |
          generate calcu.tab.h
                   |
                   v
                 FLEX
                   |
        #include "calcu.tab.h"
                   |
                   v
          know NUMBER, SUM, ...
*/

/* RE definitions */
digit   [0-9]
number  {digit}+

/* Token detection with RE */
%%
{number}    { yylval.ival = atoi(yytext); return NUMBER;  }
"+"         { strcpy(yylval.strval, yytext); return SUM;  }
"-"         { strcpy(yylval.strval, yytext); return SUB;  }
"*"         { strcpy(yylval.strval, yytext); return MULT; }
"/"         { strcpy(yylval.strval, yytext); return DIV;  }
"|"         { strcpy(yylval.strval, yytext); return ABS;  }
"\n"        { return ENDLINE; }
[ \t]+      {}
.           {}
%%