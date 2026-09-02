/* Headers - Declarations - Definitions*/
%{
#include "wordcount.tab.h"
%}
/*
                 BISON
                   |
          generate wordcount.tab.h
                   |
                   v
                 FLEX
                   |
        #include "wordcount.tab.h"
                   |
                   v
          know NUMBER, SUM, ...
*/

/* RE definitions */
letter  [a-zA-Z]
digit   [0-9]
word    {letter}({letter}|{digit})*
number  {digit}+("."{digit}+)?

/* Token detection with RE */
%%
{word}      { strcpy(yylval.strval, yytext); return WORD;   }
{number}    { yylval.ival = atoi(yytext);    return NUMBER; }
[\n]        { return NEWLINE; }
[ \t]       { return SPACE;   }
.           { return OTHER;   } /* other */
%%