%option c++
%option noyywrap


/* Headers - Declarations - Definitions*/
%{
    enum tokentype{
        NUMBER = 1,
        SUM,
        SUB,
        MULT,
        DIV,
        ABS,
        ENDLINE
    };

    int yval {0};
%}

/* Tokens rules (RE)*/

%%
[0-9]+      { yval = atoi(yytext); return NUMBER; }
"+"         { return SUM; }
"-"         { return SUB; }
"*"         { return MULT; }
"/"         { return DIV; }
"|"         { return ABS; }
"\n"        { return ENDLINE; }
[ \t]+      {}
.           {}
%%


/* User function */

int 
main(void)
{
    FlexLexer* scanner = new yyFlexLexer;
    int token{};

    while ((token = scanner->yylex()))
    {
        if (token == NUMBER){
            std::cout<<"operand: "<<yval<<'\n';
        }
        else if (token == ENDLINE){
            std::cout<<"endline\n";
        }
        else { // In C++ the current lexeme is obtained with YYText().
            std::cout<<"operator: "<<scanner->YYText() <<'\n';
        }
    }

    delete scanner;
    return 0;
}