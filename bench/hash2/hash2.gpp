// -*- mode: c++ -*-
// $Id: hash2.gpp,v 1.2 2004-11-30 07:10:03 bfulgham Exp $
// http://shootout.alioth.debian.org/

#include <stdio.h>
#include <iostream>
#include <ext/hash_map>

using namespace std;
#if (! defined(__INTEL_COMPILER))
using namespace __gnu_cxx;
#endif

struct eqstr {
   bool operator()(const char* s1, const char* s2) const {
      if (s1 == s2) return true;
      if (!s1 || !s2) return false;
      while (*s1 != '\0' && *s1 == *s2)
         s1++, s2++;
      return *s1 == *s2;
   }
};

struct strhash {
#if defined(__INTEL_COMPILER)
   enum { bucket_size = 4, min_buckets = 8 };

   bool operator()(char const *s1, char const *s2) const
        {return strcmp(s1, s2) < 0;}
#endif
   size_t operator()(const char* s) const {
      size_t i;
      for (i = 0; *s; s++)
         i = 31 * i + *s;
      return i;
   }
};

int main(int argc, char *argv[]) {
    int n = ((argc == 2) ? atoi(argv[1]) : 1);
    char buf[16];
#if defined(__INTEL_COMPILER)
    typedef hash_map<const char*, int, strhash> HM;
#else
    typedef hash_map<const char*, int, strhash, eqstr> HM;
#endif
    HM hash1, hash2;

    for (int i=0; i<10000; i++) {
        sprintf(buf, "foo_%d", i);
        hash1[strdup(buf)] = i;
    }
    for (int i=0; i<n; i++) {
        for (HM::iterator k = hash1.begin(); k != hash1.end(); ++k) {
            hash2[(*k).first] += k->second;
        }
    }
    cout << hash1["foo_1"] << " " << hash1["foo_9999"] << " "
         << hash2["foo_1"] << " " << hash2["foo_9999"] << endl;
}
