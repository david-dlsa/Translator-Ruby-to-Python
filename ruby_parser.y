%{
    #include<stdio.h>
    #include <stdlib.h>
    #include <string.h>
    FILE *python_output;
    int yyerror();
    int yylex();

  void write_to_python(char *text)
  {     int total_length = sizeof(text);
        char *file_content = malloc(total_length);
        sprintf(file_content,"%s",text);
        fprintf(python_output,"%s",file_content);
        free(file_content);
  }

%}
%union {
	char *py_string;
	int   yint;
}
%start programa
%token <py_string> IDENTIFIER
%token <py_string> STRING
%token <py_string> NUMERIC
%token DEF END PUTS LP RP RC LC LPA RPA COMMA EQ IF ELSE ELSIF EQEQ FOR IN RANGE WHILE DO PLUSEQ LESSEQ


%%

programa :
 commands
;

commands : /* Vazio */
| commands command
| commands declarations
;

command : PUTS {(write_to_python("print("));} exp {(write_to_python(")\n"));}
| /* function declaration */
  DEF {(write_to_python("def "));} IDENTIFIER {(write_to_python($3));} params {(write_to_python(":\n   "));} 
  commands {(write_to_python("\n"));}
  END {(write_to_python(""));}
| /* function call */
  IDENTIFIER {(write_to_python($1));} params {(write_to_python("\n"));} 
| IF {(write_to_python("if "));} exp_cond exp_cond {(write_to_python(":\n   "));} 
  commands 
  conditions
| FOR {(write_to_python("for "));} IDENTIFIER {(write_to_python($3));} IN {(write_to_python(" in range("));} range_types {(write_to_python("):\n    "));} 
  commands
  END {(write_to_python("\n"));}
| WHILE {(write_to_python("while "));} exp exp DO {(write_to_python(":\n    "));}
  commands
  END {(write_to_python("\n"));}
;

range_types : NUMERIC {(write_to_python($1));} RANGE {(write_to_python(", "));} NUMERIC {(write_to_python($5));}
;

conditions : /* Vazio */ END {(write_to_python("\n"));}
| ELSE {(write_to_python("else")); (write_to_python(":\n   "));} commands END {(write_to_python("\n"));}
| ELSIF {(write_to_python("elif "));} exp_cond exp_cond {(write_to_python(":\n   "));} commands conditions
;

params : /* Vazio */ {(write_to_python("()"));}
| LP {(write_to_python("("));} anything RP {(write_to_python(")"));}
;


declarations : IDENTIFIER {(write_to_python($1));} exp
;

int_vector : /* Vazio */
| anything
| anything COMMA {(write_to_python(","));} int_vector
;

anything : /* Vazio */
| STRING {(write_to_python($1));}
| NUMERIC {(write_to_python($1));}
| IDENTIFIER {(write_to_python($1));}
;

exp : STRING {(write_to_python($1));}
| NUMERIC {(write_to_python($1));}
| IDENTIFIER {(write_to_python($1));}
| EQ {(write_to_python(" = "));} exp {(write_to_python("\n"));}
| LC {(write_to_python("["));} int_vector RC {(write_to_python("]"));}
| LPA {(write_to_python("<"));} exp
| RPA {(write_to_python(">"));} exp 
| PLUSEQ {(write_to_python(" += "));} exp
| LESSEQ {(write_to_python(" -= "));} exp
/*
| exp {(write_to_python('+'));} exp
| exp {(write_to_python('-'));} exp
| exp {(write_to_python('*'));} exp
| exp {(write_to_python('/'));} exp
| exp {(write_to_python('^'));} exp
| {(write_to_python('('));} exp {(write_to_python(')'));}
*/
;

exp_cond : STRING {(write_to_python($1));}
| NUMERIC {(write_to_python($1));}
| IDENTIFIER {(write_to_python($1));}
| EQEQ {(write_to_python(" == "));} exp_cond
| LC {(write_to_python("["));} int_vector RC {(write_to_python("]"));}
| LPA {(write_to_python("<"));} exp_cond
| RPA {(write_to_python(">"));} exp_cond
;
%%

int yyerror()
{
	printf("Error \n");
  return 1;
}

int main()
{

  python_output = fopen ("python_output.py", "w");

  yyparse();
  
  return 1;
}