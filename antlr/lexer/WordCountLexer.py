# Generated from WordCountLexer.g4 by ANTLR 4.13.2
from antlr4 import *
from io import StringIO
import sys
if sys.version_info[1] > 5:
    from typing import TextIO
else:
    from typing.io import TextIO


def serializedATN():
    return [
        4,0,5,44,6,-1,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,1,
        0,1,0,1,1,1,1,5,1,18,8,1,10,1,12,1,21,9,1,1,2,4,2,24,8,2,11,2,12,
        2,25,1,2,1,2,4,2,30,8,2,11,2,12,2,31,3,2,34,8,2,1,3,3,3,37,8,3,1,
        3,1,3,1,4,1,4,1,5,1,5,0,0,6,1,0,3,1,5,2,7,3,9,4,11,5,1,0,4,1,0,48,
        57,3,0,65,90,95,95,97,122,4,0,48,57,65,90,95,95,97,122,2,0,9,9,32,
        32,47,0,3,1,0,0,0,0,5,1,0,0,0,0,7,1,0,0,0,0,9,1,0,0,0,0,11,1,0,0,
        0,1,13,1,0,0,0,3,15,1,0,0,0,5,23,1,0,0,0,7,36,1,0,0,0,9,40,1,0,0,
        0,11,42,1,0,0,0,13,14,7,0,0,0,14,2,1,0,0,0,15,19,7,1,0,0,16,18,7,
        2,0,0,17,16,1,0,0,0,18,21,1,0,0,0,19,17,1,0,0,0,19,20,1,0,0,0,20,
        4,1,0,0,0,21,19,1,0,0,0,22,24,3,1,0,0,23,22,1,0,0,0,24,25,1,0,0,
        0,25,23,1,0,0,0,25,26,1,0,0,0,26,33,1,0,0,0,27,29,5,46,0,0,28,30,
        3,1,0,0,29,28,1,0,0,0,30,31,1,0,0,0,31,29,1,0,0,0,31,32,1,0,0,0,
        32,34,1,0,0,0,33,27,1,0,0,0,33,34,1,0,0,0,34,6,1,0,0,0,35,37,5,13,
        0,0,36,35,1,0,0,0,36,37,1,0,0,0,37,38,1,0,0,0,38,39,5,10,0,0,39,
        8,1,0,0,0,40,41,7,3,0,0,41,10,1,0,0,0,42,43,9,0,0,0,43,12,1,0,0,
        0,6,0,19,25,31,33,36,0
    ]

class WordCountLexer(Lexer):

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    WORD = 1
    NUMBER = 2
    NEWLINE = 3
    SPACE = 4
    OTHER = 5

    channelNames = [ u"DEFAULT_TOKEN_CHANNEL", u"HIDDEN" ]

    modeNames = [ "DEFAULT_MODE" ]

    literalNames = [ "<INVALID>",
 ]

    symbolicNames = [ "<INVALID>",
            "WORD", "NUMBER", "NEWLINE", "SPACE", "OTHER" ]

    ruleNames = [ "DIGIT", "WORD", "NUMBER", "NEWLINE", "SPACE", "OTHER" ]

    grammarFileName = "WordCountLexer.g4"

    def __init__(self, input=None, output:TextIO = sys.stdout):
        super().__init__(input, output)
        self.checkVersion("4.13.2")
        self._interp = LexerATNSimulator(self, self.atn, self.decisionsToDFA, PredictionContextCache())
        self._actions = None
        self._predicates = None


