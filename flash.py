#!/usr/bin/python

from os.path import expanduser
import sys
import random

#TODO: command-line deck of flashcards, graceful program exit, put it on GitHub, correct parsing of decks of flashcards

f = list(map(lambda l: l.split(), open(expanduser("~/.flashcards/" + "doom")).read().splitlines()))
n = len(f)

while True:
    a = random.randint(0,n-1)
    print(f[a][0])
    if sys.stdin.readline().strip() != f[a][1]:
        print("INCORRECT! (%s)" % f[a][1])
