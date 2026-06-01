lexer grammar BasicLexer;

@header {
    package com.basic4gl.compiler;
}

channels {
	 WHITESPACE_CHANNEL,
	 COMMENTS_CHANNEL
}

IDENTIFIER
	: (LETTER | UNDERSCORE) (LETTER | DIGIT | UNDERSCORE)
	;

NUMBER_LITERAL
	: INTEGER_LITERAL
	| FLOAT_LITERAL
	;

INTEGER_LITERAL
	: DIGIT+
	;

FLOAT_LITERAL
	: DIGIT* '.' DIGIT+ 
	;

ENDOFLINE
	: '\r\n'
	| '\r'
	| '\n' ;
		
FILENAME : [^<>:\"|?*]+ ;

SUFFIX : '$' | PERCENT | '#' ;

LETTER : [a-zA-Z];
DIGIT : ('0' .. '9');

SINGLEQUOTE : '\'';
DOUBLEQUOTE : '\"';
OPENPAREN : '(';
CLOSEPAREN : ')';
UNDERSCORE : '_';
COLON : ':';
COMMA : ',';

/* Keywords */
DIALECT: TRADITIONAL | BASIC4GL | TRADITIONAL_PRINT | TRADITIONAL_SUFFIX;

INCLUDE : 'include' ;
REM : 'rem';

/* Variables */
DIM : 'dim' ;
AS : 'as' ;
INTEGER : 'integer' ;
SINGLE : 'single' ;
DOUBLE : 'double' ;
STRING : 'string' ;

GOTO : 'goto' ;
IF : 'if' ;
THEN : 'then' ;
ELSEIF : 'elseif' ;
ELSE : 'else' ;
ENDIF : 'endif';
END : 'end' ;
GOSUB : 'gosub' ;
RETURN : 'return' ;
FOR : 'for' ;
TO : 'to' ;
STEP : 'step' ;
NEXT : 'next' ;
WHILE : 'while' ;
WEND : 'wend' ;
RUN : 'run' ;
STRUC : 'struc' ;
ENDSTRUC : 'endstruc' ;
CONST : 'const' ;
ALLOC : 'alloc' ;
NULL : 'null' ;
DATA : 'data' ;
READ : 'read' ;
RESET : 'reset' ;
TYPE : 'type' ;
LANGUAGE : 'language' ;
TRADITIONAL : 'traditional' ;
BASIC4GL : 'basic4gl' ;
TRADITIONAL_PRINT : 'traditional_print' ;
TRADITIONAL_SUFFIX : 'traditional_suffix' ;
INPUT : 'input' ;
DO : 'do' ;
LOOP : 'loop' ;
UNTIL : 'until' ;
FUNCTION : 'function' ;
SUB : 'sub' ;
ENDFUNCTION : 'endfunction' ;
ENDSUB : 'endsub' ;
DECLARE : 'declare' ;
RUNTIME : 'runtime' ;
BINDCODE : 'bindcode' ;
EXEC : 'exec' ;
ARRAYMAX : 'arraymax' ;
BEGINCODEBLOCK : 'begincodeblock' ;
ENDCODEBLOCK : 'endcodeblock' ;

/* Operators. */

OR: 'or';
AND: 'and';
XOR: 'xor';
LOR: 'lor';
LAND: 'land';
NOT: 'not';
EQUALS: '=';
NOTEQUALS: '<>';
GT: '>';
GE: '>=';
LT: '<';
LE: '<=';
PLUS: '+';
MINUS: '-';
ASTERISK: '*';
PERCENT: '%';
SLASH: '/';

COMMENT : (SINGLEQUOTE | REM) (~ [\r\n])* -> channel(COMMENTS_CHANNEL) ;

WS : [ \r\n\t]+ -> channel (WHITESPACE_CHANNEL) ;
