%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
%}

%option noyywrap

DIGITO   [0-9]
LETRA    [A-Za-zÁÉÍÓÚáéíóúñÑ]
ID       {LETRA}({LETRA}|{DIGITO}|_)*

%%

empleado                { return EMPLEADO; }
salario                 { return SALARIO; }
";"                     { return PUNTOCOMA; }

/* identificador de empleado */
{ID} {
    yylval.str = strdup(yytext);
    return ID;
}

/* número (puede ser entero o decimal) */
{DIGITO}+("."{DIGITO}+)? {
    yylval.num = atof(yytext);
    return NUM;
}

/* espacios y tabs -> se ignoran */
[ \t\r]+                ;

/* fin de línea -> se lo pasamos al parser */
\n                      { return NEWLINE; }

/* cualquier otro carácter desconocido */
. {
    yylval.str = strdup(yytext);
    return UNKNOWN;
}

%%
