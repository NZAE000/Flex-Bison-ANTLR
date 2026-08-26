lexer grammar WordCountLexer;

fragment DIGIT
    : [0-9]
    ;

WORD
    : [a-zA-Z_] [a-zA-Z0-9_]*
    ;

NUMBER
    : DIGIT+ ('.' DIGIT+)?
    ;

NEWLINE
    : '\r'? '\n'
    ;

SPACE
    : [ \t]
    ;

OTHER
    : .
    ;