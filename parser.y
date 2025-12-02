%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int total_salarios = 0;
void yyerror(const char *s);
int yylex(void);
%}

%union {
    int num;
    char *str;
}

%token EMPLEADO SALARIO
%token <str> ID
%token <num> NUM

%type <num> linea

%%

input:
      /* vacío */
    | input linea '\n'
    ;

linea:
    EMPLEADO ID SALARIO NUM ';'
    {
        printf("Empleado %s -> salario: %d\n", $2, $4);
        total_salarios += $4;
        free($2);
        $$ = $4;
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(int argc, char **argv) {
    if (yyparse() == 0) {
        printf("Total global de salarios: %d\n", total_salarios);
    }
    return 0;
}
