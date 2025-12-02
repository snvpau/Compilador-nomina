#include <stdio.h>

int yyparse(void);
extern FILE *yyin;

int main(int argc, char *argv[]) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("No se pudo abrir el archivo de entrada");
            return 1;
        }
    }

    yyparse();

    if (yyin && yyin != stdin) {
        fclose(yyin);
    }

    return 0;
}
