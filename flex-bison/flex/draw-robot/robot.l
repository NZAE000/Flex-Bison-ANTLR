/* to generate c++ file*/
%option c++
%option noyywrap

/*Declarations, definitions, headers*/
%{
    enum yytokentype {
        AVANZAR = 1,
        RETROCEDER,
        GIRAR_DERECHA,
        GIRAR_IZQUIERDA,
        LEVANTAR_LAPIZ,
        BAJAR_LAPIZ,
        SELECCIONAR_COLOR,
        COLOR,
        VAR,
        IDENT,
        EQUAL,
        NUMBER,
        UNKNOWN
    };

    int yyval {};
    std::string yystr{};
%}

/*Token detection rules*/

word [a-zA-Z_][a-zA-Z0-9_]*
number [0-9]+"."[0-9]+|[0-9]+

%%
"AVANZAR"              { yystr = YYText(); return AVANZAR; }
"RETROCEDER"           { yystr = YYText(); return RETROCEDER; }
"GIRAR_DERECHA"        { yystr = YYText(); return GIRAR_DERECHA; }
"GIRAR_IZQUIERDA"      { yystr = YYText(); return GIRAR_IZQUIERDA; }
"LEVANTAR_LAPIZ"       { yystr = YYText(); return LEVANTAR_LAPIZ; }
"BAJAR_LAPIZ"          { yystr = YYText(); return BAJAR_LAPIZ; }
"SELECCIONAR_COLOR"    { yystr = YYText(); return SELECCIONAR_COLOR; }
"VAR"                  { yystr = YYText(); return VAR; }
"="                    { yystr = YYText(); return EQUAL; }
"ROJO"                 { yystr = YYText(); return COLOR; }
"VERDE"                { yystr = YYText(); return COLOR; }
"AZUL"                 { yystr = YYText(); return COLOR; }
"NEGRO"                { yystr = YYText(); return COLOR; }
{word}                 { yystr = YYText(); return IDENT; }
{number}               { yyval = std::atoi(YYText()); return NUMBER; }
"#".*                  { /*ignore*/ }
[ \t]                  { /*ignore*/ }
[\n]                   { /*ignore*/ }
.                      { yystr = YYText(); return UNKNOWN; }
%%



/* User functions */

int main()
{
    FlexLexer* lexer = new yyFlexLexer;
    int token {};

    while ((token = lexer->yylex()))
    {
        if (token == NUMBER)        std::cout<< "Number "<<yyval<< " detected\n";
        else if (token == IDENT)    std::cout<< "Identifier "<<yystr<< " detected\n";
        else if (token == EQUAL)    std::cout<< "Operator "<<yystr<< " detected\n";
        else if (token == COLOR)    std::cout<< "Color "<<yystr<< " detected\n";
        else {
            switch(token){
                case UNKNOWN:
                    std::cout<<"Unkown token: "<<yystr<<'\n';
                    break;
                default:
                    std::cout<<"Command "<<yystr<< " detected\n";
                    break;
            }
        }
    }

    delete lexer;

    return 0;
}





