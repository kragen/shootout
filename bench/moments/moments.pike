#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: moments.pike,v 1.1 2004-05-19 18:10:48 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/
// from: Fredrik Noring

class Moments
{
    int N;
    float median;
    float mean;
    float average_deviation;
    float standard_deviation;
    float variance;
    float skew;
    float kurtosis;
    
    void create(array(float) v)
    {
        float sum = `+(@v);
        N = sizeof(v);
        mean = sum / N;

        foreach(v, float i)
        {
            float deviation = i - mean;
            average_deviation += abs(deviation);
            variance += pow(deviation, 2);
            skew += pow(deviation, 3);
            kurtosis += pow(deviation, 4);
        }

        average_deviation /= N;
        variance /= (N - 1);
        standard_deviation = sqrt(variance);

        if (variance)
        {
            skew /= (N * variance * standard_deviation);
            kurtosis = kurtosis/(N * variance * variance) - 3.0;
        }

        sort(v);
        int mid = N/2;
        median = N % 2 ? v[mid] : (v[mid] + v[mid-1])/2;
    }
};

int main()
{
    array input = Stdio.stdin.read()/"\n";
    Moments m=Moments( (array(float)) input[..sizeof(input)-2] );

    write("n:                  %d\n", m->N);
    write("median:             %.6f\n", m->median);
    write("mean:               %.6f\n", m->mean);
    write("average_deviation:  %.6f\n", m->average_deviation);
    write("standard_deviation: %.6f\n", m->standard_deviation);
    write("variance:           %.6f\n", m->variance);
    write("skew:               %.6f\n", m->skew);
    write("kurtosis:           %.6f\n", m->kurtosis);
}
