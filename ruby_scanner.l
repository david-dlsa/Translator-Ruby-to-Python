%{
#include "y.tab.h"
#include<stdlib.h>
#include<stdio.h>
%}
%option yylineno


DIGIT    [0-9]
IDENTIFIER [a-z][a-z0-9]*
ALL_DIGITS [\nA-Za-z0-9!#$%&'()*+,-./:;?@[\\\]_`{|}~  ]*

STRING ["]{ALL_DIGITS}["]
%%

"puts" {return PUTS;}
"def" {return FUNCAO;}
{IDENTIFIER} { yylval.p_string=malloc(yyleng); sprintf(yylval.p_string,"%s",yytext);return IDENTIFIER;}
"(" {return LP;}
")" {return RP;}
"end" {return END;}
{STRING} {yylval.p_string=malloc(yyleng); sprintf(yylval.p_string,"%s",yytext);return STRING;}
[\n\t ]+	{/* ignoring newlines, tabs and spaces */}

%%


