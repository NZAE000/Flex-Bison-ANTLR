#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol_table.h"

static Symbol *symbol_table = NULL;

Symbol* find_symbol(const char *name) {
    for (Symbol *s = symbol_table; s != NULL; s = s->next) {
        if (strcmp(s->name, name) == 0)
            return s;
    }
    return NULL;
}

Symbol* insert_symbol(const char *name, float value) {
    Symbol *s = find_symbol(name);
    if (s != NULL) {
        s->value = value;
        return s;
    }

    s = malloc(sizeof(Symbol));
    s->name = strdup(name);
    s->value = value;
    s->next = symbol_table;
    symbol_table = s;
    return s;
}

void print_symbols(void) {
    printf("\n--- Symbol table ---\n");
    for (Symbol *s = symbol_table; s != NULL; s = s->next) {
        printf("%s = %.2f\n", s->name, s->value);
    }
    printf("--------------------------\n");
}

void free_symbols(void) {
    Symbol *s = symbol_table;
    while (s) {
        Symbol *tmp = s;
        s = s->next;
        free(tmp->name);
        free(tmp);
    }
    symbol_table = NULL;
}
