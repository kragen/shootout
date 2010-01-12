# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
#
# contributed by anon
# modified by Pilho Kim (first GMP version)
# modified by 2to3 and Daniel Nanz

import sys
from itertools import islice
from gmpy import mpz

 
(MPZ0, MPZ1, MPZ2, MPZ3, MPZ4, MPZ10) = (mpz(i) for i in (0, 1, 2, 3, 4, 10))


def gen_x(zero=MPZ0, one=MPZ1, two=MPZ2, four=MPZ4):

    a, b, d = zero, two, one
    while True:
        a += one
        b += four
        d += two
        yield (a, b, zero, d)


def compose(q1, q2):

    a, b, c, d = q1
    e, f, g, h = q2
    return (a * e,  a * f + b * h,  c * e + d * g,  c * f + d * h)


def extract(q, j):
    
    a, b, c, d = q
    return (a * j + b) // (c * j + d)


def pi_digits(x=gen_x(), extr=extract, comp=compose, zero=MPZ0, 
              one=MPZ1, three=MPZ3, four=MPZ4, ten=MPZ10, mten=-MPZ10):

    z = (one, zero, zero, one)
    while True:
        y = extr(z, three)
        while y != extr(z, four):
            z = comp(z, next(x))
            y = extr(z, three)
        z = comp((ten, mten * y, zero, one), z)
        yield str(y)


def main(n, digits=pi_digits(), width=10, line='{}\t:{}'):

    for i in range(width, n+1, width):
        print(line.format(''.join(islice(digits, width)), i))
    if n % width > 0:
        print(line.format(''.join(islice(digits, n % width)).ljust(width), n))


main(int(sys.argv[1]))
