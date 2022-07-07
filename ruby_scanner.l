%{
#include "y.tab.h"
#include<stdlib.h>
#include<stdio.h>
%}
%option yylineno


DIGIT    [0-9]+
IDENTIFIER [A-Za-z0-9]*
ALL_DIGITS [\nA-Za-z0-9!#$%&'()*+,-./:;?@[\\\]_`{|}~  ]*
EQ "="
EQEQ "=="
PLUSEQ "+="
LESSEQ "-="

STRING ["]{ALL_DIGITS}["]
NUMERIC {DIGIT}
%%

"puts" {return PUTS;}
"def" {return DEF;}
"if" {return IF;}
"else" {return ELSE;}
"elsif" {return ELSIF;}
"for" {return FOR;}
"in" {return IN;}
".." {return RANGE;}
"while" {return WHILE;}
"do" {return DO;}
"gets.chomp" {return GP;}
"end" {return END;}
{NUMERIC} {yylval.py_string=malloc(yyleng); sprintf(yylval.py_string,"%s",yytext);return NUMERIC;}
{IDENTIFIER} { yylval.py_string=malloc(yyleng); sprintf(yylval.py_string,"%s",yytext);return IDENTIFIER;}
"(" {return LP;}
")" {return RP;}
"[" {return LC;}
"]" {return RC;}
"," {return COMMA;}
"<" {return LPA;}
">" {return RPA;}
{EQ} {return EQ;}
{EQEQ} {return EQEQ;}
{PLUSEQ} {return PLUSEQ;}
{LESSEQ} {return LESSEQ;}
{STRING} {yylval.py_string=malloc(yyleng); sprintf(yylval.py_string,"%s",yytext);return STRING;}
[\n\t ]+	{/* ignoring newlines, tabs and spaces */}

%%


