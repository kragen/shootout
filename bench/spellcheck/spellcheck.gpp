// -*- mode: c++ -*-
// $Id: spellcheck.gpp,v 1.3 2005-05-13 16:24:19 igouy-guest Exp $
// http://shootout.alioth.debian.org/ 
// STL spell checker from Bill Lear

#include <iostream>
#include <utility>
#include <fstream>
#include <ext/hash_map>
#include <algorithm>
#include <iomanip>

using namespace std;

#if defined(__INTEL_COMPILER)
#define SGI_HASH_NAMESPACE std
using std::hash;
using std::hash_map;
#else
#define SGI_HASH_NAMESPACE __gnu_cxx

namespace sgi {
    using SGI_HASH_NAMESPACE::hash;
    using SGI_HASH_NAMESPACE::hash_map;
}
#endif

typedef std::pair<const char*, const char*> span;

namespace SGI_HASH_NAMESPACE {
    template<> struct hash<span> {
        inline size_t operator()(const span& s) const {
            size_t h = 0;
            const char* end = s.second;
            for (const char* begin = s.first; begin != end; ++begin) {
                h = 5 * h + *begin;
            }
            return h;
        }
    };
}

namespace std {
    template<> struct equal_to<span> {
        inline bool operator()(const span& s1, const span& s2) const {
            return (s1.second - s1.first) == (s2.second - s2.first) &&
                equal(s1.first, s1.second, s2.first);
        }
    };

#if defined(__INTEL_COMPILER)
    struct str_hash_compare {
        enum { bucket_size = 4, min_buckets = 8 };

        bool operator()(const span& s1, const span& s2) const {
	    int len1 = s1.second - s1.first;
	    int len2 = s2.second - s2.first;

	    int min = (len1 > len2) ? len2 : len1;
	    
            return (strncmp(s1.first, s2.first, min) < 0);
	}

        inline size_t operator()(const span& s) const {
            size_t h = 0;
            const char* end = s.second;
            for (const char* begin = s.first; begin != end; ++begin) {
                h = 5 * h + *begin;
            }
            return h;
        }
     };
#endif
}
class spell_checker {
public:
    spell_checker() {
        std::ifstream in("Usr.Dict.Words");
        char line[32];
        while (in.getline(line, 32)) {
            const char* begin = line;
            const char* end = line + in.gcount() - 1;
            if (dict.end() == dict.find(span(begin, end))) {
                const size_t len = end - begin;
                char* word = new char[len];
                copy(begin, end, word);
                ++dict[span(word, word + len)];
            }
         }
    }

    void process(std::istream& in) {
        char line[32];
        while (in.getline(line, 32)) {
            if (dict.end() == dict.find(span(line, line + in.gcount() - 1))) {
                cout << line << '\n';
            }
        }
    }

private:
#if (defined(__INTEL_COMPILER))
    std::hash_map<span, int, str_hash_compare> dict;
#else
    __gnu_cxx::hash_map<span, int> dict;
#endif
};

int main() {
    spell_checker spell;
    char buff[4096];
    cin.rdbuf()->pubsetbuf(buff, 4096); // enable buffering
    spell.process(cin);
}
