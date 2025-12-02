%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
%}

%option noyywrap

%%

"empleado"      { return EMPLEADO; }

/* cadena entre comillas  */
\"[^\"]*\"      {
                    /* quitamos las comillas */
                    int len = yyleng - 2;
                    char *s = (char*)malloc(len + 1);
                    strncpy(s, yytext + 1, len);
                    s[len] = '\0';
                    yylval.str = s;
                    return STRING;
                }

/* num enteros */
[0-9]+          {
                    yylval.num = atoi(yytext);
                    return NUMERO;
                }

/* simbolos individuales que el parser usa como tokens char */
"("             { return '('; }
")"             { return ')'; }
","             { return ','; }
";"             { return ';'; }
"+"             { return '+'; }
"-"             { return '-'; }

/* espacios y tabs: ignorar */
[ \t\r]+        ;

/* saltos de línea los ignoramos */
\n              ;

/* cualquier otro carácter desconocido */
.               {
                    /* podrías reportar error, pero por ahora lo ignoramos */
                    /* printf("Caracter desconocido: %s\n", yytext); */
                }

%%
