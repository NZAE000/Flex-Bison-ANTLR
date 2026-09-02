/* It tells the generated code not to call yywrap(); Flex takes care of terminating when it finds EOF. */
%option noyywrap

/* Headers - Declarations - Definitions */
%{
#include <stdio.h>
#include <stdint.h>

uint32_t n_lines   = 0;
uint32_t n_words   = 0;
uint32_t n_numbers = 0;
uint32_t n_chars   = 0;
uint32_t n_spaces  = 0;
uint32_t n_others  = 0;
%}


/* Token detection rules with RE */
%%
[a-zA-Z][a-zA-Z0-9_]*  { ++n_words;   n_chars += yyleng; }
[0-9]+("."[0-9]+)?     { ++n_numbers; n_chars += yyleng; }
[\n]                   { ++n_lines;   ++n_chars; }
[ \t]                  { ++n_spaces;  ++n_chars; }
.                      { ++n_others;  ++n_chars; }    /* other */
%%


/* Functions */

int main(void)
{
    // 'yylex()' is still running and waiting for more characters from stdin. It only terminates when it receives `EOF`, for example, by pressing Ctrl+D on macOS/Linux.
    // whe yylex() detect EOF, call 'yywrap'.
    yylex(); 

    printf("Lines: %u\n", n_lines);
    printf("Words: %u\n", n_words);
    printf("Numbers: %u\n", n_numbers);
    printf("Characters: %u\n", n_chars);
    printf("Spaces: %u\n", n_spaces);
    printf("Others: %u\n", n_others);

    return 0;
}