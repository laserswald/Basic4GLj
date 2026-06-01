parser grammar BasicParser;

@header {
package com.basic4gl.compiler;
}

options {
	tokenVocab = BasicLexer;
}

// Top-level programs.
program
	: (language_decl commandsep)? block
	;

// The language dialect. Must be the first line in the file.
language_decl
	: LANGUAGE DIALECT
	;

// A block of code.
block
	: command (commandsep command)*
	;

// BASIC instructions, labels, and function or type definitions.
command
	: label
	| stmt
	| defn;

commandsep
	: COLON
	| ENDOFLINE
	;

// A marked section of code; can be jumped to by GOTO or GOSUB.
label
	: IDENTIFIER COLON
	;

// Do some work.
stmt
	: includestmt
	| dimstmt
	| conststmt
	| assignstmt
	| gotostmt
	| ifstmt
	| whilestmt
	| forstmt
	| dostmt
	| returnstmt
	| datastmt
	| readstmt
	| resetstmt;

// Include another BASIC file.
includestmt
	: INCLUDE FILENAME
	;

// Declare variables. (short for dimension)
dimstmt
	: DIM vardecl (COMMA vardecl)*
	;

// Declare immutable data.
conststmt
	: CONST assignstmt (COMMA assignstmt)*
	;

// Assign a new value to a variable.
assignstmt
	: varexpr EQUALS expression
	;

// Jump to a section of code. Only works in the top-level.
gotostmt
	: GOTO IDENTIFIER
	| GOSUB IDENTIFIER
	; 

// Execute code depending on a condition.
ifstmt
	: IF expression THEN block (ELSEIF expression THEN block)* (ELSE block)? (ENDIF | END IF)
    ;

// Repeat a block while the expression is true.
whilestmt
	: WHILE expression commandsep block WEND
	;

// Repeat a block, but with a numeric variable changing each iteration.
forstmt
	: FOR IDENTIFIER SUFFIX? EQUALS expression TO expression (STEP NUMBER_LITERAL) commandsep block NEXT
	;

// Repeat a block either indefinitely or until a condition is true (or false) at the
// beginning or end of the block
dostmt
	: DO block LOOP
	| DO WHILE expression commandsep block LOOP
	| DO UNTIL expression commandsep block LOOP
	| DO commandsep block LOOP WHILE expression
	| DO commandsep block LOOP UNTIL expression
	;

// Return from a subroutine, function, or labeled block.
returnstmt
	: RETURN
	| RETURN expression
	;

// Define inline data elements.
datastmt
	: DATA element (COMMA element)*
	;

element
	: NUMBER_LITERAL
	| (~ COMMA)+;

// Set variables to values previously declared in a DATA statement.
readstmt
	: READ IDENTIFIER SUFFIX? (COMMA IDENTIFIER SUFFIX?)*
	;

// Reset the internal pointer for a DATA statement
resetstmt
	: RESET IDENTIFIER
	;

// Define names for subroutines, functions, data types, etc.
defn
	: subdefn
	| funcdefn
	| forwarddecl
	| structdefn
	;

subdefn
	: SUB IDENTIFIER OPENPAREN parameters CLOSEPAREN commandsep block subend
	;

subend
	: ENDSUB
	| END SUB
	;

funcdefn
	: FUNCTION IDENTIFIER SUFFIX? OPENPAREN parameters CLOSEPAREN commandsep block funcend
	;

funcend
	: ENDFUNCTION
	| END FUNCTION
	;

parameters
	: (vardecl (COMMA vardecl)+)?
	;

forwarddecl
	: DECLARE FUNCTION IDENTIFIER SUFFIX? OPENPAREN parameters CLOSEPAREN
	;

structdefn
	: STRUC IDENTIFIER dimstmt+ ENDSTRUC
	| TYPE IDENTIFIER vardecl+ END TYPE
	;

expression
	: IDENTIFIER OPENPAREN arguments CLOSEPAREN
	| expression logicalop expression
	| expression comparisonOp expression
	| expression mulOp expression
	| expression sumOp expression
	| sumOp expression
	| OPENPAREN expression CLOSEPAREN
	| literal
	| varexpr
	;

arguments
	: expression (COMMA expression)*
	;

varexpr
	: IDENTIFIER SUFFIX? subscript*
	;

vardecl
	: IDENTIFIER (AS vartype)?
	| vartype IDENTIFIER (subscript)*
	| IDENTIFIER SUFFIX? (subscript)*
	;

subscript
	: OPENPAREN INTEGER CLOSEPAREN
	;

vartype
	: INTEGER
	| SINGLE
	| DOUBLE
	| STRING
	| IDENTIFIER
	;

logicalop
	: OR | AND | XOR | LOR | LAND;

comparisonOp
	: EQUALS
	| NOTEQUALS
	| GT
	| GE
	| LT
	| LE
	;

sumOp
	: PLUS
	| MINUS
	;

mulOp
	: ASTERISK
	| SLASH
	| PERCENT
	;

literal
	: DOUBLEQUOTE (~ (DOUBLEQUOTE | ENDOFLINE)) DOUBLEQUOTE
	| NUMBER_LITERAL
	;
