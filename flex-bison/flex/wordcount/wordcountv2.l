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

/* Token definition */
enum Token {
    TOKEN_WORD = 256,
    TOKEN_NUMBER,
    TOKEN_NEWLINE,
    TOKEN_SPACE,
    TOKEN_OTHER
};

%}


/* Regular definitions */
letter  [a-zA-Z]
digit   [0-9]
word    {letter}({letter}|{digit})*
number  {digit}+("."{digit}+)?

/* Token detection rules with RE */
%%
{word}      { ++n_words;   n_chars += yyleng; return TOKEN_WORD;    }
{number}    { ++n_numbers; n_chars += yyleng; return TOKEN_NUMBER;  }
[\n]        { ++n_lines;   ++n_chars; return TOKEN_NEWLINE;         }
[ \t]       { ++n_spaces;  ++n_chars; return TOKEN_SPACE;           }
.           { ++n_others;  ++n_chars; return TOKEN_OTHER;           }    /* other */
%%


/* Functions */

int yywrap(void) {
    return 1; /* There are no more inputs. */
}

int main(void)
{
    int token;
    while ((token = yylex()) != 0)  // Without `return`, `yylex()` continues searching for lexemes until EOF. With `return`, `yylex()` delivers a token and relinquishes control to the caller.
    {
        switch (token) {
            case TOKEN_WORD:
                printf("TOKEN_WORD: %s\n", yytext);
                break;

            case TOKEN_NUMBER:
                printf("TOKEN_NUMBER: %s\n", yytext);
                break;

            case TOKEN_NEWLINE:
                printf("TOKEN_NEWLINE\n");
                break;

            case TOKEN_SPACE:
                printf("TOKEN_SPACE\n");
                break;

            case TOKEN_OTHER:
                printf("TOKEN_OTHER: %s\n", yytext);
                break;
        }
    }

    printf("Lines: %u\n", n_lines);
    printf("Words: %u\n", n_words);
    printf("Numbers: %u\n", n_numbers);
    printf("Characters: %u\n", n_chars);
    printf("Spaces: %u\n", n_spaces);
    printf("Others: %u\n", n_others);

    return 0;
}