/* Headers - Declarations - Definitions*/
%{
#include<stdio.h>

int yylex();
void yyerror(const char*);

%}

/* Define tokens */

%union {
    int ival;
    char strval[5];
}

%token<ival> NUMBER
%token<strval> SUM
%token<strval> SUB
%token<strval> MULT
%token<strval> DIV
%token<strval> ABS
%token ENDLINE

/*No-terminals types*/
%type<strval> operator
%type<ival> operand

/* Grammar rules */

%%
input: 
    | input operand  { printf("operand = %d\n", $2); } 
    | input operator { printf("operator = %s\n", $2); }
    | input endline  { printf("endline\n"); }
    ;
operator: SUM
    |   SUB
    |   MULT
    |   DIV
    |   ABS
    ;
operand: NUMBER
    ;
endline: ENDLINE
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