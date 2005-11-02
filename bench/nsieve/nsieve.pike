/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Adam Montague
*/

int nsieve(int m)
{
	array(int) flags = allocate(m + 1, 1);
	int count;

	for (int i = 2; i <= m; i++) {
		if (flags[i]) {
			for (int j = i + i; j <= m; j += i) {
				flags[j] = 0;
			}
			count++;
		}
	}
	return (count);
}

int main(int argc, array(string) argv)
{
	int n = (int)argv[1];
	if (n < 2)
		n = 2;
	int m;

	m = (1 << n) * 10000;
	write("Primes up to %8d %8d\n", m, nsieve(m));

	m = (1 << n - 1) * 10000;
	write("Primes up to %8d %8d\n", m, nsieve(m));

	m = (1 << n - 2) * 10000;
	write("Primes up to %8d %8d\n", m, nsieve(m));
}
