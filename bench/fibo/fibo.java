// $Id: fibo.java,v 1.2 2005-03-19 00:32:56 igouy-guest Exp $
// http://www.bagley.org/~doug/shootout/

public class fibo {
    public static void main(String args[]) {
	int N = Integer.parseInt(args[0]);
	System.out.println(fib(N));
    }
    public static int fib(int n) {
	if (n < 2) return(n);
	return( fib(n-2) + fib(n-1) );
    }
}
