// -*- mode: c++ -*-
// $Id moments.gpp,v 1.1.1.1 2004/05/19 18:10:47 bfulgham Exp $
// http://shootout.alioth.debian.org/
// Calculate statistical moments of a region, from Bill Lear
// Modified by Tamás Benkõ
// Further modified by Tom Hyer

#include <vector>
#include <numeric>
#include <iterator>
#include <algorithm>
#include <iomanip>
#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cmath>

using namespace std;

template <class T>
struct moments {
public:
    template <class InputIterator>
    moments(InputIterator begin, InputIterator end)
        : median(0.0), mean(0.0), average_deviation(0.0),
          standard_deviation(0.0), variance(0.0),
          skew(0.0), kurtosis(0.0)
        {
            T sum = accumulate(begin, end, 0.0);
            size_t N = end - begin;
            mean = sum / N;
            for (InputIterator i = begin; i != end; ++i) {
                T deviation = *i - mean;
                average_deviation += fabs(deviation);
				T temp = deviation * deviation;
                variance += temp;
				temp *= deviation;
                skew += temp;
                kurtosis += temp * deviation;
            }
            average_deviation /= N;
            variance /= (N - 1);
            standard_deviation = sqrt(variance);

            if (variance) {
                skew /= (N * variance * standard_deviation);
                kurtosis = kurtosis/(N * variance * variance) - 3.0;
            }

            InputIterator mid = begin+N/2;
            nth_element(begin, mid, end);
            if (N % 2 == 0) {
				InputIterator next_biggest = max_element(begin, 
mid);
                median = (*mid+*next_biggest)/2;
            }
			else
				median = *mid;
        }

    T median;
    T mean;
    T average_deviation;
    T standard_deviation;
    T variance;
    T skew;
    T kurtosis;
};

int main() {
    vector<double> v;
    double d;

    while (scanf(" %lf", &d) == 1) v.push_back(d);
    moments<double> m(v.begin(), v.end());

    cout << std::fixed << std::setprecision(6);
    cout << "n:                  " << v.end() - v.begin() << endl;
    cout << "median:             " << m.median << endl;
    cout << "mean:               " << m.mean << endl;
    cout << "average_deviation:  " << m.average_deviation << endl;
    cout << "standard_deviation: " << m.standard_deviation << endl;
    cout << "variance:           " << m.variance << endl;
    cout << "skew:               " << m.skew << endl;
    cout << "kurtosis:           " << m.kurtosis << endl;

    return 0;
}
