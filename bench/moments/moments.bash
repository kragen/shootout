# ----------------------------------------------------------------------
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Anthony Borla
# ----------------------------------------------------------------------

BCGEN="/tmp/$USER$$.awk"

# Generate script to perform arbitrary precision calculations
(
cat<<'EOF'
  BEGIN{
    print "sum=0; n=0; median=0; mean=0; avgdev=0; stddev=0; variance=0; skew=0; kurtosis=0;"
  }

  {
    print "data[n++] = " $1 "; sum += " $1 ";"
  }

  END{
    print "define abs(m) {"
    print "if (m < 0) return(-m) else return(m);"
    print "}" 

    print "mid = n / 2; k = mid - 1;"
    print "if (n % 2) median = data[mid] else median = (data[k] + data[mid]) / 2;"

    print "mean = sum / n;"     

    print "for (i = 0; i < n; i++) {"
    print "dev = data[i] - mean;"
    print "avgdev = avgdev + abs(dev);"
    print "variance = variance + dev ^ 2;"
    print "skew = skew + dev ^ 3;"
    print "kurtosis = kurtosis + dev ^ 4;"
    print "}"

    print "avgdev = avgdev / n;"
    print "variance = variance / (n - 1);"
    print "stddev = sqrt(variance);"
    print "if (variance > 0) {"
    print "skew = skew / (n * variance * stddev);"
    print "kurtosis = kurtosis / (n * variance * variance) - 3.0;"
    print "}"

    print "n; median; mean; avgdev; stddev; variance; skew; kurtosis;"
  }
EOF
) > ${BCGEN}

# Compute statistics
SUMMARY=(`sort -n | awk -f ${BCGEN} | bc -l`)

# Display results
printf 'n:                  %d\n' ${SUMMARY[0]}
printf 'median:             %0.6f\n' ${SUMMARY[1]}
printf 'mean:               %0.6f\n' ${SUMMARY[2]}
printf 'average_deviation:  %0.6f\n' ${SUMMARY[3]}
printf 'standard_deviation: %0.6f\n' ${SUMMARY[4]}
printf 'variance:           %0.6f\n' ${SUMMARY[5]}
printf 'skew:               %0.6f\n' ${SUMMARY[6]}
printf 'kurtosis:           %0.6f\n' ${SUMMARY[7]}

# Cleanup
rm -f ${BCGEN}
