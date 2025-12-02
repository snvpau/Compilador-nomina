%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

extern FILE *yyin;

double total_global = 0.0;
%}

%union {
    char  *str;
    double num;
}

/* tokens que vienen del lexer */
%token EMPLEADO SALARIO PUNTOCOMA NEWLINE
%token <str> ID
%token <num> NUM
%token UNKNOWN

%type  <num> linea definicion

%%

input:
      /* vacío */
    | input linea
    ;

linea:
      definicion NEWLINE
    | NEWLINE
    ;

definicion:
      EMPLEADO ID SALARIO NUM PUNTOCOMA
    {
        printf("Empleado %-10s -> salario: %.2f\n", $2, $4);
        total_global += $4;
        free($2);
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error de sintaxis: %s\n", s);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("No se pudo abrir el archivo de entrada");
            return 1;
        }
    }

    yyparse();

    printf("Total global de salarios: %.2f\n", total_global);
    return 0;
}
