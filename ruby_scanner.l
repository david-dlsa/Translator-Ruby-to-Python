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

STRING ["]{ALL_DIGITS}["]
NUMERIC {DIGIT}
%%

"puts" {return PUTS;}
"def" {return DEF;}
"end" {return END;}
{IDENTIFIER} { yylval.py_string=malloc(yyleng); sprintf(yylval.py_string,"%s",yytext);return IDENTIFIER;}
"(" {return LP;}
")" {return RP;}
{EQ} {return EQ;}
{STRING} {yylval.py_string=malloc(yyleng); sprintf(yylval.py_string,"%s",yytext);return STRING;}
{NUMERIC} {yylval.py_string=malloc(yyleng); sprintf(yylval.py_string,"%s",yytext);return NUMERIC;}
[\n\t ]+	{/* ignoring newlines, tabs and spaces */}

%%


