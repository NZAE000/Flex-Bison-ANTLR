# Language Implementation with Lexical and Syntax Analysis using Flex-Bison and ANTLR

This repository contains practical exercises focused on understanding and applying **lexical and syntax analysis** using **Flex-Bison** and **ANTLR**. The main purpose is to understand the separation between lexical analysis (token recognition) and syntax analysis (grammar and structure recognition), and how these stages can be combined to implement programming languages, domain-specific languages (DSLs), interpreters, calculators, and other programs based on language-processing techniques.

The exercises progress from simple lexical analyzers to applications that integrate lexical and syntax analysis.

# Setup

## Install Flex and Bison

### Linux

```bash
sudo apt update
sudo apt install flex bison
```

### macOS

```bash
brew install flex
brew install bison
```

### Windows

Use MinGW64 or WSL.

---

## Install ANTLR

### Linux

```bash
sudo apt update
sudo apt install antlr4
```

### macOS

```bash
brew install antlr
```

### Windows

Use MinGW64 or WSL.

### Python Runtime

When using Python 3 as the ANTLR target language, install the ANTLR Python runtime:

```bash
python3 -m pip install antlr4-python3-runtime
```

# Build

## With Lex/Flex

### Generate the lexical analyzer

Generate `lex.yy.c` from the Lex/Flex specification:

```bash
flex file.l
```

### Compile the C program

```bash
gcc lex.yy.c -lfl -o exec
```

### Execute

```bash
./exec
```

An input file can also be redirected to the program:

```bash
./exec < input.txt
```

## With Flex-Bison

### Generate the parser

First, generate `file.tab.c` and `file.tab.h` using Bison. The `-d` flag generates the header file containing the token definitions:

```bash
bison -d file.y
```

### Generate the lexical analyzer

Then, generate `file.yy.c` using Flex. The `-o` flag specifies the output filename:

```bash
flex -o file.yy.c file.l
```

### Compile and execute

Finally, compile the generated C files:

```bash
gcc *.c -lfl -o exec
```

Then execute:

```bash
./exec
```

Both commands can also be executed together:

```bash
gcc *.c -lfl -o exec && ./exec
```

## With Makefile

By default, the Makefile builds the `calcu` program using the V1 version.

### Build a specific version

```bash
make VERSION=Vx
```

For example:

```bash
make VERSION=V2
```

### Clean a specific version

```bash
make clean VERSION=Vx
```

### Clean all generated files

```bash
make cleanall VERSION=Vx
```

## With ANTLR

The examples use Python 3 as the ANTLR target language.

### Generate the lexer

Generate the Python lexer and its associated files from the ANTLR grammar:

```bash
antlr4 -Dlanguage=Python3 file.g4
```

ANTLR generates files such as:

```text
file.py
file.tokens
file.interp
```

### Run the client program

The client program (e.g., `main.py`) creates the generated lexer from an `InputStream` or `FileStream`.

Execute it with:

```bash
python3 main.py
```

An input file can also be redirected through standard input:

```bash
python3 main.py < input.txt
```