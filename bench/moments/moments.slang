define main ()
{
   variable nums = array_map (Double_Type, &atof, fgetslines (stdin));
   variable n = length (nums);
   variable sum_nums = sum (nums);
   variable mean = sum_nums/n;

   variable deviation = nums - mean;
   variable average_deviation = sum (abs(deviation))/n;
   variable variance = sum (deviation^2)/(n-1);
   variable skew = sum (deviation^3);
   variable kurtosis = sum (deviation^4);
   variable standard_deviation = sqrt(variance);
     
   if (variance > 0.0)
     {
        skew /= (n * variance * standard_deviation);
        kurtosis = kurtosis/(n * variance * variance) - 3.0;
     }

   nums = nums[array_sort(nums)];
   variable mid = n/2;
   variable median;

    if (n mod 2)
     median = nums[mid];
   else
     median = (nums[mid] + nums[mid-1])/2;

   fprintf (stdout, "n:                  %d\n", n);
   fprintf (stdout, "median:             %f\n", median);
   fprintf (stdout, "mean:               %f\n", mean);
   fprintf (stdout, "average_deviation:  %f\n", average_deviation);
   fprintf (stdout, "standard_deviation: %f\n", standard_deviation);
   fprintf (stdout, "variance:           %f\n", variance);
   fprintf (stdout, "skew:               %f\n", skew);
   fprintf (stdout, "kurtosis:           %f\n", kurtosis);
}
main ();
