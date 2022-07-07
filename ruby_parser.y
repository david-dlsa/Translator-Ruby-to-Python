%{
    #include<stdio.h>
    #include <stdlib.h>
    #include <string.h>
    FILE *python_output;
    int yyerror();
    int yylex();

    void write_on_output_file(char *text){     
        int total_length = sizeof(text);
        char *file_content = malloc(total_length);
        sprintf(file_content,"%s",text);
        fprintf(output_portugol,"%s",file_content);
        free(file_content);
    }

%}
%union {
	char *string;
	int   yint;
}
%start programa
%token <string> IDENTIFIER
%token <string> STRING
%token <string> INT
%token <string> FLOAT
%token <string> NUMBER
%token FUNCAO END PUTS LP RP


%%

programa :
 commands
;

/*
function_declaration: FUNCAO IDENTIFIER LP RP
{
  char *function_name = element_name($2);
  char *function_type = "void";
  char *function_params = "void";
  char *open_block = "{";
  int total_length = sizeof(function_name) + sizeof(function_type) + sizeof(function_params)+ sizeof(open_block);
  char *file_content = malloc(total_length);

  sprintf(file_content,"%s %s(){ ",function_type,function_name);
  fprintf(output_portugol,"%s",file_content);
}
;
*/
commands : /* empty */
| commands command
;

command : PUTS STRING
{ fprintf(python_output,"print(%s)", STRING);}
/*
| READ IDENTIFIER
|IDENTIFIER ASSGNOP exp
| IF exp commands END
| WHILE exp DO commands END
| FOR exp 
*/
;

/*
exp :

| NUMBER
| IDENTIFIER
| exp '<' exp
| exp '=' exp
| exp '>' exp
| exp '+' exp
| exp '-' exp
| exp '*' exp
| exp '/' exp
| exp '^' exp
| '(' exp ')'
*/
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