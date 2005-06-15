#!/usr/bin/pike

/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Adam Montague 
*/

float takfp(float x, float y, float z)
{
	return (y >=x) ? z : takfp(takfp(x - 1.0, y, z), takfp(y - 1.0, z, x), takfp(z - 1.0, x, y));
}

void main(int argc, array(string) argv)
{
	float n = (float)argv[1];
	write("%.1f\n", takfp(n * 3.0, n * 2.0, n * 1.0));
}
