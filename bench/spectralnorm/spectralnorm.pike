// The Computer Language Shootout
// http://shootout.alioth.debian.org/
// contributed by Adam Montague

float A(int i, int j)
{
	return 1.0 / ((i + j) * (i + j + 1) / 2 + i + 1);
}

float Av(int n, array(float) v, array(float) Av)
{
	for (int i = 0; i < n; i++) {
		Av[i] = 0.0;
		for (int j = 0; j < n; j++) {
			Av[i] += A(i, j) * v[j];
		}
	}
}

float Atv(int n, array(float) v, array(float) Atv)
{
	for (int i = 0; i < n; i++) {
		Atv[i] = 0.0;
		for (int j = 0; j < n; j++) {
			Atv[i] += A(j, i) * v[j];
		}
	}
}

float AtAv(int n, array(float) v, array(float) AtAv)
{
	array(float) u = allocate(n);
	Av(n, v, u);
	Atv(n, u, AtAv);
}

void main(int argc, array(string) argv)
{
	int n = (int)argv[1];
	array(float) u = allocate(n, 1.0);
	array(float) v = allocate(n);

	for (int i = 0; i < 10; i++) {
		AtAv(n, u, v);
		AtAv(n, v, u);
	}

	float vBv, vv;
	for (int i = 0; i < n; i++) {
		vBv += u[i] * v[i];
		vv += v[i] * v[i];
	}

	write("%.9f\n", sqrt(vBv / vv));
}
