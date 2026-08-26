import sys

from antlr4 import InputStream
from antlr4.Token import Token

from WordCountLexer import WordCountLexer


def main():
    text = sys.stdin.read()

    lexer = WordCountLexer(InputStream(text))

    n_lines = 0
    n_words = 0
    n_numbers = 0
    n_chars = 0
    n_spaces = 0
    n_others = 0

    token = lexer.nextToken()

    while token.type != Token.EOF:
        if token.type == WordCountLexer.WORD:
            n_words += 1
            n_chars += len(token.text)

        elif token.type == WordCountLexer.NUMBER:
            n_numbers += 1
            n_chars += len(token.text)

        elif token.type == WordCountLexer.NEWLINE:
            n_lines += 1
            n_chars += len(token.text)

        elif token.type == WordCountLexer.SPACE:
            n_spaces += 1
            n_chars += len(token.text)

        elif token.type == WordCountLexer.OTHER:
            n_others += 1
            n_chars += len(token.text)

        token = lexer.nextToken()

    print(f"Lines: {n_lines}")
    print(f"Words: {n_words}")
    print(f"Numbers: {n_numbers}")
    print(f"Characters: {n_chars}")
    print(f"Spaces: {n_spaces}")
    print(f"Others: {n_others}")


if __name__ == "__main__":
    main()