module:         moments
synopsis:       implementation of "Statistical Moments" benchmark
author:         Peter Hinely
copyright:      public domain
use-libraries:  common-dylan, io, transcendental
use-modules:    common-dylan, standard-io, streams, format-out, transcendental


define constant <vector-of-doubles> = limited(<simple-vector>, of: <double-float>);


define function main () => ()
  let lines = make(<stretchy-vector>);

  let line = #f;
  while (line := read-line(*standard-input*, on-end-of-stream: #f))
    add!(lines, line);
  end;

  let nums = make(<vector-of-doubles>, size: lines.size);
  map-into(nums, string-to-float, lines);

  let sum = 0.0;

  // use a for loop instead of reduce1 so "+" can be resolved
  for (num in nums)
    sum := sum + num;
  end;

  let n = nums.size;
  let mean = sum / n;
  let average-deviation = 0.0;
  let variance = 0.0;
  let skew = 0.0;
  let kurtosis = 0.0;

  for (num in nums)
    let deviation = num - mean;
    average-deviation := average-deviation + abs(deviation);
    variance := variance + (deviation ^ 2);
    skew := skew + (deviation ^ 3);
    kurtosis := kurtosis + (deviation ^ 4);
  end;

  average-deviation := average-deviation / n;
  variance := variance / (n - 1);
  let standard-deviation = sqrt(variance);

  if (variance > 0.0)
    skew := skew / (n * variance * standard-deviation);
    kurtosis := (kurtosis / (n * variance * variance)) - 3.0;
  end;

  sort!(nums); // We could improve execution speed by implementing quickselect instead of relying on quicksort
  let mid = floor/(n, 2);

  let median = 0;
  if (even?(n))
    median := (nums[mid] + nums[mid - 1]) / 2;
  else
    median := nums[mid];
  end;

  format-out("n:                  %d\n", n);
  format-out("median:             %=\n", median);
  format-out("mean:               %=\n", mean);
  format-out("average_deviation:  %=\n", average-deviation);
  format-out("standard_deviation: %=\n", standard-deviation);
  format-out("variance:           %=\n", variance);
  format-out("skew:               %=\n", skew);
  format-out("kurtosis:           %=\n", kurtosis);
end function;


main();
