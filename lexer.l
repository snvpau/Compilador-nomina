%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%option noyywrap

ID      [A-Za-zÁÉÍÓÚáéíóúñÑ]+
NUM     [0-9]+

%%

"empleado"     { return EMPLEADO; }
"salario"      { return SALARIO; }
{ID}           { yylval.str = strdup(yytext); return ID; }
{NUM}          { yylval.num = atoi(yytext);  return NUM; }

[ \t\r]+       ;          /* ignorar espacios y tabs */
\n             { return '\n'; }
";"            { return ';'; }

/* cualquier otro carácter lo ignoramos */
.              ;

%%

