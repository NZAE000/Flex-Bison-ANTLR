%option noyywrap

/* Headres, definitions, declarations */
%{

#include<stdio.h>
#include<stdlib.h>
#include<math.h> 

#define DATA_CAPACITY 35
#define STORAGE_CAPACITY 6

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

void statistics(char const* word, unsigned* vals, int size)
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

typedef struct wordData { /* Storage data of some word (ER) belong this languge: 'Lines', 'Words', 'NUmbers', etc */

    char const* word_;
    enum Token  token_;
    unsigned*   data_;
    unsigned    size_;

} WordData_t;

int
main()
{
    int token = 0;

    WordData_t wordata_storage[STORAGE_CAPACITY] = 
    {
        { "Lines:",      NEWLINES_W,   (unsigned*) malloc(DATA_CAPACITY * sizeof(unsigned)), 0},
        { "Words:",      WORDS_W,      (unsigned*) malloc(DATA_CAPACITY * sizeof(unsigned)), 0},
        { "Numbers:",    NUMBERS_W,    (unsigned*) malloc(DATA_CAPACITY * sizeof(unsigned)), 0},
        { "Characters:", CHARACTERS_W, (unsigned*) malloc(DATA_CAPACITY * sizeof(unsigned)), 0},
        { "Spaces:",     SPACES_W,     (unsigned*) malloc(DATA_CAPACITY * sizeof(unsigned)), 0},
        { "Others:",     OTHERS_W,     (unsigned*) malloc(DATA_CAPACITY * sizeof(unsigned)), 0},
    };


    while ((token = yylex()) != 0)  // Without `return`, `yylex()` continues searching for lexemes until EOF. With `return`, `yylex()` delivers a token and relinquishes control to the caller.
    {
        for (unsigned i=0; i<STORAGE_CAPACITY; ++i)
        {   
            WordData_t* wdata = &wordata_storage[i];
            if (token == wdata->token_)
                if (yylex() == VALUE)
                {
                    unsigned val = (unsigned) atoi(yytext);
                    *(wdata->data_ + wdata->size_) = val;
                    ++wdata->size_;
                }
        }
    }

    printf("Stadistics..\n\n");
    for (unsigned i=0; i<STORAGE_CAPACITY; ++i)
    {
        WordData_t* wdata = &wordata_storage[i];
        statistics(wdata->word_, wdata->data_, wdata->size_);
    }

    // Free!
    for (unsigned i=0; i<STORAGE_CAPACITY; ++i)
        free(wordata_storage[i].data_);

    return 0;
}