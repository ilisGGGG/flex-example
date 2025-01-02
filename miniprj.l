
%{
#include <stdio.h>
#include <stdlib.h>

%}

// Regular Definitions
entier [0-9]+
id_var \$[a-zA-Z_][a-zA-Z0-9_]*
id_func [a-zA-Z_][a-zA-Z0-9_]*
keyword (si|alors|sinon|tantque|faire|retour|lire|ecrire|entier)
operator (\+|\-|\*|/|<|=|&|\||!)
symbol (;|\{|\}|\(|\)|\[|\])

%%

{keyword}     { printf("KEYWORD: %s\n", yytext); }
{operator}    { printf("OPERATOR: %s\n", yytext); }
{symbol}      { printf("SYMBOL: %s\n", yytext); }
{id_var}      { printf("ID_VAR: %s\n", yytext); }
{id_func}     { printf("ID_FUNC: %s\n", yytext); }
{entier}      { printf("NOMBRE: %s\n", yytext); }

#.*            { /* Ignore single-line comments */ }
[ \t\n]+       { /* Ignore whitespace */ }
<<EOF>>        { printf("End of File\n"); return 0; }

.              { printf("Error: Unrecognized token '%s'\n", yytext); exit(1); }

%%

int main() {
    yyin = fopen("input.txt", "r");
    if (!yyin) {
        perror("Error opening file");
        return 1;
    }
    yylex();
    fclose(yyin);
    return 0;
}