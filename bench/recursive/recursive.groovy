// ---------------------------------------------------------------------
// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
// 
// Use JRE 1.4 features only [JRE 1.5 'printf' would have helped better
// streamline code]
//
// Contributed by Anthony Borla
// ---------------------------------------------------------------------

import java.text.DecimalFormat

def main()
{
  n = Integer.parseInt(args[0]) ; fmt = new DecimalFormat(".#")

  result = ack(3, n) ; println "Ack(3,${n}): ${result}" 

  arg = fmt.format(27.0 + n) ; result = fmt.format(fib(27.0 + n))
  println "Fib(${arg}): ${result}"

  n -= 1 ; arg1 = n * 3 ; arg2 = n * 2 ; result = tak(n * 3, n * 2, n)
  println "Tak(${arg1},${arg2},${n}): ${result}"

  result = fib(3) ; println "Fib(3): ${result}" 
  result = fmt.format(tak(3.0, 2.0, 1.0)) ; println "Tak(3.0,2.0,1.0): ${result}"
}

// --------------------------------

def ack(x, y)
{
  if (x == 0) return y + 1
  if (y == 0) return ack(x - 1, 1)
  return ack(x - 1, ack(x, y - 1))
}

// --------------

def fib(n)
{
  if (n < 2) return 1
  return fib(n - 2) + fib(n - 1)
}

// --------------

def tak(x, y, z)
{
  if (y < x) return tak(tak(x - 1, y, z), tak(y - 1, z, x), tak(z - 1, x, y))
  return z
}

// --------------------------------

main()

