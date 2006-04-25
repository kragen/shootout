/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Anthony Borla. This is a slightly modified version
   of, 'nsieve.pike' by Adam Montague, which uses a standard integer 
   array with 'bit twiddling' to perform data encoding / decoding
*/

int nsieve(int m)
{
	int size = (m + 31) >> 5; int count;

	array(int) flags = allocate(size, 0xffffffff);

	for (int i = 2; i < m; i++) {
		if (flags[i >> 5] & 1 << (i & 31)) {
			for (int j = i + i; j < m; j += i) {
				flags[j >> 5] &= ~(1 << (j & 31));
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

