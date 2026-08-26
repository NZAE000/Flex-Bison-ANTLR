/* Headers - Declarations - Definitions*/
%{
#include<stdio.h>
#include<util/calculus.h>

int yylex();
void yyerror(const char*);

%}

/* Define tokens */

%union {
    float fval;
}

%token<fval> NUMBER
%token SUM
%token SUB
%token MULT
%token DIV
%token ABS
%token ENDLINE

/*No-terminals types*/
%type<fval> expression term factor

/* Grammar rules */

/* 2*3+5+1 */
/* 2+3*5+1 */


%%
input: 
    | input expression ENDLINE { printf("%f\n", $2); }
    | input ENDLINE
    ;
expression: factor
    | expression SUM factor { $$ = sum($1, $3); }
    | expression SUB factor { $$ = sub($1, $3); }
    ;
factor: term
    | factor MULT term { $$ = mul($1, $3); }
    | factor DIV term { $$ = divi($1, $3); }
    ;
term: NUMBER
    ;
%%


/* User function */


void yyerror(const char* mssg)
{   
    printf("penca %s", mssg);
}

int 
main(void)
{
    yyparse();
    return 0;
}