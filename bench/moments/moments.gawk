# $Id: moments.gawk,v 1.1 2004-05-19 18:10:47 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

BEGIN {
    delete ARGV;
    sum = 0;
    n = 0;
}

{
    nums[n++] = $1;
    sum += $1;
}

END {
    mean = sum/n;
    for (num in nums) {
	dev = num - mean;
	if (dev > 0) { avg_dev += dev; } else { avg_dev -= dev; }
	vari += dev^2;
	skew += dev^3;
	kurt += dev^4;
    }
    avg_dev /= n;
    vari /= (n - 1);
    std_dev = sqrt(vari);

    if (vari > 0) {
	skew /= (n * vari * std_dev);
	kurt = kurt/(n * vari * vari) - 3.0;
    }

    nums[n] = nums[0];
    heapsort(n, nums);

    mid = int(n/2)+1;
    median = (n % 2) ? nums[mid] : (nums[mid] + nums[mid-1])/2;

    printf("n:                  %d\n", n);
    printf("median:             %f\n", median);
    printf("mean:               %f\n", mean);
    printf("average_deviation:  %f\n", avg_dev);
    printf("standard_deviation: %f\n", std_dev);
    printf("variance:           %f\n", vari);
    printf("skew:               %f\n", skew);
    printf("kurtosis:           %f\n", kurt);
}

function heapsort (n, ra) {
    l = int(0.5+n/2) + 1
    ir = n;
    for (;;) {
        if (l > 1) {
            rra = ra[--l];
        } else {
            rra = ra[ir];
            ra[ir] = ra[1];
            if (--ir == 1) {
                ra[1] = rra;
                return;
            }
        }
        i = l;
        j = l * 2;
        while (j <= ir) {
            if (j < ir && ra[j] < ra[j+1]) { ++j; }
            if (rra < ra[j]) {
                ra[i] = ra[j];
                j += (i = j);
            } else {
                j = ir + 1;
            }
        }
        ra[i] = rra;
    }
}
