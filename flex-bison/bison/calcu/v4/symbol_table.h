#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

// Linked list
typedef struct Symbol {
    char *name;          // Id name
    float value;         // Number value
    struct Symbol *next; // Next symbol
} Symbol;


Symbol* insert_symbol(const char *name, float value);
Symbol* find_symbol(const char *name);
void print_symbols(void);
void free_symbols(void);

#endif
