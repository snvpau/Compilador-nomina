%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);

%}

%union {
    int   num;
    char *str;
}

/* tokens */
%token EMPLEADO
%token <str> STRING
%token <num> NUMERO

%type  <num> expresion

%%

input
    : /* vacío */
    | input linea
    ;

linea
    : EMPLEADO '(' STRING ',' expresion ')' ';'
      {
          printf("Empleado %s -> salario neto = %d\n", $3, $5);
          free($3);
      }
    ;

expresion
    : NUMERO
      { $$ = $1; }
    | expresion '+' NUMERO
      { $$ = $1 + $3; }
    | expresion '-' NUMERO
      { $$ = $1 - $3; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error de sintaxis: %s\n", s);
}
