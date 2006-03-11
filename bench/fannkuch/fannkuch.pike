/**
 * fannkuch.pike by Robert Brandner
 * heavily based on the Java JDK-client version by Paul Lofte
 */
int main(int argc, array(string) argv) {
	int n = (int)argv[1];
	write("Pfannkuchen(" + n + ") = " + fannkuch(n)+"\n");
}

int fannkuch(int n) {
    int check = 0;
    array(int) perm = allocate(n);
    array(int) perm1 = allocate(n);
    array(int) count = allocate(n);
    array(int) maxPerm = allocate(n);
    int maxFlipsCount = 0;
    int m = n - 1;

    for (int i = 0; i < n; i++) perm1[i] = i;
    int r = n;

    while (1) {
        // write-out the first 30 permutations
        if (check < 30){
          for(int i=0; i<n; i++) write((string)(perm1[i]+1));
          write("\n");
          check++;
        }

        while (r != 1) { count[r - 1] = r; r--; }
        if (!(perm1[0] == 0 || perm1[m] == m)) {
            for (int i = 0; i < n; i++) perm[i] = perm1[i];

            int flipsCount = 0;
            int k;

            while (!((k = perm[0]) == 0)) {
                int k2 = (k + 1) >> 1;
                for (int i = 0; i < k2; i++) {
                    int temp = perm[i]; perm[i] = perm[k - i]; perm[k - i] = temp;
                }
                flipsCount++;
            }

            if (flipsCount > maxFlipsCount) {
                maxFlipsCount = flipsCount;
                for (int i = 0; i < n; i++) maxPerm[i] = perm1[i];
            }
        }

        while (1) {
            if (r == n) return maxFlipsCount;
            int perm0 = perm1[0];
            int i = 0;
            while (i < r) {
                int j = i + 1;
                perm1[i] = perm1[j];
                i = j;
            }
            perm1[r] = perm0;

            count[r] = count[r] - 1;
            if (count[r] > 0) break;
            r++;
        }
    }
}

