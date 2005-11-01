/* The Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Adam Montague
*/

void main(int argc, array(string) argv)
{
	int n = (int)argv[1];
	float sum;
	for (int i = 1; i <= n; i++)
		sum += 1.0 / i;
	write("%.9f\n", sum);
}
