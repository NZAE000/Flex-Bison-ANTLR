%{
#include <stdio.h>
#include <stdlib.h>
#include "symbol_table.h"
#include <util/calculus.h>

int yylex();
void yyerror(const char*);
%}

/* Union types */
%union {
    float fval;
    struct Symbol* sval;
}

/* Tokens */
%token <fval> NUMBER
%token <sval> IDENTIFIER
%token SUM SUB MULT DIV ABS ASSIGN ENDLINE

/* Non-terminals */
%type <fval> expression term factor

%%

input:
      /* vacío */
    | input line
    ;

line:
      expression ENDLINE           { printf("%f\n", $1); }
    | IDENTIFIER ASSIGN expression ENDLINE {
          $1->value = $3;
          printf("%s = %f\n", $1->name, $3);
      }
    | ENDLINE
    ;

expression:
      factor
    | expression SUM factor        { $$ = sum($1, $3); }
    | expression SUB factor        { $$ = sub($1, $3); }
    ;

factor:
      term
    | factor MULT term             { $$ = mul($1, $3); }
    | factor DIV term              { $$ = divi($1, $3); }
    ;

term:
      NUMBER
    | IDENTIFIER                   { $$ = $1->value; }
    ;

%%

void yyerror(const char* mssg)
{
    fprintf(stderr, "Error: %s\n", mssg);
}

int main(void)
{
    yyparse();
    print_symbols();
    free_symbols();
    return 0;
}
