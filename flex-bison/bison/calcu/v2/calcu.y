/* Headers - Declarations - Definitions*/
%{
#include<stdio.h>

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
%type<fval> expression term

/* Grammar rules */

/* 2 */
/* 2+3+5 */

%%
input: 
    | input expression ENDLINE { printf("%f\n", $2);    }
    | input ENDLINE
    ;
expression: term
    | expression SUM term { $$ = $1 + $3; }
    | expression SUB term { $$ = $1 - $3; }
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