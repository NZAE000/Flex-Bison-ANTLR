%option noyywrap

/* Headres, definitions, declarations */
%{

#include<stdio.h>
#include<stdlib.h>
#include<math.h> 

#define CAPACITY 35

enum Token {
    NEWLINES_W = 256,
    WORDS_W,
    NUMBERS_W,
    CHARACTERS_W,
    SPACES_W,
    OTHERS_W,
    VALUE
};

%}

/* Regular definitions */
digit   [0-9]
number  {digit}+("."{digit}+)?

/* Token detection rules with RE */
%%
"Lines:"         { return NEWLINES_W;    }
"Words:"         { return WORDS_W;       }
"Numbers:"       { return NUMBERS_W;     }
"Characters:"    { return CHARACTERS_W;  }
"Spaces:"        { return SPACES_W;      }
"Others:"        { return OTHERS_W;      }
{number}         { return VALUE;         }
[ \t\n]+         { /* Ignore whitespace */ }
.                { /* Ignore others */ }
%%

/* Functions */

void statistics(char const* word, int* vals, int size)
{
    printf("%s\n", word);

    // Average
    float sum = 0;
    for (int i=0; i < size; ++i) sum += *(vals + i);
    float avg = sum / size;

    // Standard deviation
    float sum_squares = 0;

    for (int i=0; i < size; i++)
        sum_squares += pow(*(vals + i) - avg, 2);

    float variance = sum_squares / size;
    float stdd = sqrt(variance);
    
    printf("\tTotal %f\n", sum);
    printf("\tAvg %f\n", avg);
    printf("\tVar %f\n", variance);
    printf("\tStdd %f\n", stdd);
}

int
main()
{
    int token;

    // Vectors
    int* line_vals      = (int*) malloc(CAPACITY * sizeof(int));
    int* word_vals      = (int*) malloc(CAPACITY * sizeof(int));
    int* number_vals    = (int*) malloc(CAPACITY * sizeof(int));
    int* character_vals = (int*) malloc(CAPACITY * sizeof(int));
    int* space_vals     = (int*) malloc(CAPACITY * sizeof(int));
    int* other_vals    = (int*) malloc(CAPACITY * sizeof(int));

    // Counter
    int line_count   = 0;
    int word_count   = 0;
    int number_count = 0;
    int char_count   = 0;
    int space_count  = 0;
    int other_count  = 0;

    while ((token = yylex()) != 0)  // Without `return`, `yylex()` continues searching for lexemes until EOF. With `return`, `yylex()` delivers a token and relinquishes control to the caller.
    {
        switch (token) 
        {
            case NEWLINES_W:
                if (yylex() == VALUE){
                    int val = atoi(yytext);
                    *(line_vals + line_count) = val;
                    ++line_count;
                }
                break;

            case WORDS_W:
                if (yylex() == VALUE){
                    int val = atoi(yytext);
                    *(word_vals + word_count) = val;
                    ++word_count;
                }
                break;

            case NUMBERS_W:
                if (yylex() == VALUE){
                    int val = atoi(yytext);
                    *(number_vals + number_count) = val;
                    ++number_count;
                }
                break;

            case CHARACTERS_W:
                if (yylex() == VALUE){
                    int val = atoi(yytext);
                    *(character_vals + char_count) = val;
                    ++char_count;
                }
                break;

            case SPACES_W:
                if (yylex() == VALUE){
                    int val = atoi(yytext);
                    *(space_vals + space_count) = val;
                    ++space_count;
                }
                break;

            case OTHERS_W:
                if (yylex() == VALUE){
                    int val = atoi(yytext);
                    *(other_vals + other_count) = val;
                    ++other_count;
                }
                break;

            default:
                break;
        }
    }

    printf("Stadistics..\n\n");
    statistics("Lines", line_vals, line_count);
    statistics("Words", word_vals, word_count);
    statistics("Numbers", number_vals, number_count);
    statistics("Characters", character_vals, char_count);
    statistics("Spaces", space_vals, space_count);
    statistics("Others", other_vals, other_count);

    // Free!
    free(line_vals);
    free(word_vals);
    free(number_vals);
    free(character_vals);
    free(space_vals);
    free(other_vals);

    return 0;
}