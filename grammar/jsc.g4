grammar jsc;

file
    : expr EOF
    ;

object
    : LEFT_CURLY (pair (COMMA pair)*)? RIGHT_CURLY
    ;

array
    : LEFT_BRACKET (expr (COMMA expr)*)? RIGHT_BRACKET
    ;

pair
    : expr COLON expr
;

expr
    : object
    | array
    | func
    | STRING
    | 'f' STRING
    | NUMBER
    | BOOLEAN
    | NULL
    ;

func
    :
    ;

// LEXER

STRING
    : '"' (ESC | SAFECODEPOINT)* '"'
    ;

NUMBER
    : MINUS? DIGIT+ (DOT DIGIT+)? EXP?
    | MINUS? DOT DIGIT+ EXP?
    ;

BOOLEAN
    : 'true'
    | 'false'
    ;

NULL
    : 'null'
    ;

LEFT_CURLY
    : '{'
    ;

RIGHT_CURLY
    : '}'
    ;

LEFT_BRACKET
    : '['
    ;

RIGHT_BRACKET
    : ']'
    ;

MINUS
    : '-'
    ;

PLUS
    : '+'
    ;

DOT
    : '.'
    ;

COMMA
    : ','
    ;

COLON
    : ':'
    ;

WS
    : [ \t\r\n]+ -> skip
    ;

fragment DIGIT
    : [0-9]
    ;
fragment EXP
    : [eE] [+-]? DIGIT+
    ;
fragment ESC
    : '\\' (["\\/bfnrt] | UNICODE)
    ;
fragment UNICODE
    : 'u' HEX HEX HEX HEX
    ;
fragment HEX
    : [0-9a-fA-F]
    ;
fragment SAFECODEPOINT
    : ~ ["\\\u0000-\u001F]
    ;
