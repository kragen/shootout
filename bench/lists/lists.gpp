// -*- mode: c++ -*-
// $Id: lists.gpp,v 1.2 2004-11-30 07:10:03 bfulgham Exp $
// http://shootout.alioth.debian.org/
// from Bill Lear, with improvements by Thomas Hyer
//
// 08-16-2004:  Revised by the Gwydion Dylan Maintainers to use
//   the Deque class, which provides a realistic implementation
//   of this test (i.e., with good performance).

#include <algorithm>
#include <iostream>
#include <deque>
#include <numeric>
#if (defined(__INTEL_COMPILER))
#define __gnu_cxx std
#else
#include <ext/numeric>
#endif

using namespace std;

const size_t SIZE = 10000;

size_t test_lists() {
    std::deque<size_t> li1(SIZE);

    __gnu_cxx::iota(li1.begin(), li1.end(), 1);

    std::deque<size_t> li2(li1), li3;

    while (! li2.empty()) {
        li3.push_back(li2.front());
        li2.pop_front();
    }

    while (! li3.empty()) {
        li2.push_back(li3.back());
        li3.pop_back();
    }

    //li1.reverse();
    reverse(li1.begin(), li1.end());

    return (li1.front() == SIZE) && (li1 == li2) ? li1.size() : 0;
}

int main(int argc, char* argv[]) {
    size_t ITER = (argc == 2 ? (atoi(argv[1]) < 1 ? 1 : atoi(argv[1])): 1);

    size_t result = 0;
    while (ITER > 0) {
        result = test_lists();
        --ITER;
    }

    std::cout << result << std::endl;
}
