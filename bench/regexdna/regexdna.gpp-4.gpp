// The Computer Language Benchmarks Game
// http://shootout.alioth.debian.org/
//
// Contributed by The Anh Tran

#include <omp.h>
#include <sched.h>
#include <memory.h>

#include <cassert>
#include <cstdio>

#include <iostream>
#include <vector>
#include <iterator>

#include <boost/format.hpp>
#include <boost/scoped_array.hpp>
#include <boost/xpressive/xpressive_static.hpp>


using namespace boost::xpressive;
namespace x = boost::xpressive;
using namespace std;

typedef char         Char_T;
typedef Char_T const*   PChar_T;
typedef vector<Char_T>   Data_T;

typedef Data_T::const_iterator         CIte_Data_T;
typedef back_insert_iterator<Data_T>   OIte_Data_T;

typedef basic_regex<CIte_Data_T>      Regex_Data_T;



// read all redirected data from stdin
// strip DNA headers and newline characters
size_t 
ReadInput_StripHeader(   size_t &file_size, Data_T &output )
{
   // get input size
   file_size = ftell(stdin);
   fseek(stdin, 0, SEEK_END);
   file_size = ftell(stdin) - file_size;
   fseek(stdin, 0, SEEK_SET);
   file_size /= sizeof(Char_T);


   // load content into memory
   boost::scoped_array<Char_T> p_src(new Char_T[file_size +1]);
   {
      size_t sz = fread(p_src.get(), sizeof(Char_T), file_size, stdin);
      assert(sz == file_size);
      p_src[file_size] = 0;
   }

   
   PChar_T p_src_beg = p_src.get();
   PChar_T p_src_end = p_src_beg + file_size;
   output.reserve (file_size);

   regex_replace (   OIte_Data_T(output), 
               p_src_beg, p_src_end, 

               // ">.*\n | \n"
               basic_regex<PChar_T>( as_xpr('>') >> *(~_n) >> _n | _n ),

               ""); 

   return output.size();
}



void 
Count_Patterns(Data_T const& input, string& result)
{
   typedef std::pair<PChar_T, Regex_Data_T> PReg;
   
   static PReg const ptns[] = 
   {
      PReg("agggtaaa|tttaccct",   
         as_xpr("agggtaaa") | "tttaccct"   ),

      PReg("[cgt]gggtaaa|tttaccc[acg]",   
            (x::set='c','g','t') >> "gggtaaa"
         |    "tttaccc" >> (x::set='a','c','g')   ),

      PReg("a[act]ggtaaa|tttacc[agt]t",   
            as_xpr('a') >> (x::set='a','c','t') >> "ggtaaa"
         |   "tttacc" >> (x::set='a','g','t') >> 't'   ),

      PReg("ag[act]gtaaa|tttac[agt]ct",   
            as_xpr("ag") >> (x::set='a','c','t') >> "gtaaa"
         |   "tttac" >> (x::set='a','g','t') >> "ct"   ),
         
      PReg("agg[act]taaa|ttta[agt]cct",   
            as_xpr("agg") >> (x::set='a','c','t') >> "taaa"
         |   "ttta" >> (x::set='a','g','t') >> "cct"   ),
         
      PReg("aggg[acg]aaa|ttt[cgt]ccct",   
            as_xpr("aggg") >> (x::set='a','c','g') >> "aaa"
         |   "ttt" >> (x::set='c','g','t') >> "ccct"   ),
         
      PReg("agggt[cgt]aa|tt[acg]accct",   
            as_xpr("agggt") >> (x::set='c','g','t') >> "aa"
         |   "tt" >> (x::set='a','c','g') >> "accct"   ),
         
      PReg("agggta[cgt]a|t[acg]taccct",   
            as_xpr("agggta") >> (x::set='c','g','t') >> 'a'   
         |   't' >> (x::set='a','c','g') >> "taccct"   ),
         
      PReg("agggtaa[cgt]|[acg]ttaccct",   
            as_xpr("agggtaa") >> (x::set='c','g','t')
         |   (x::set='a','c','g') >> "ttaccct"   )
   };
   static int const n_ptns = sizeof(ptns) / sizeof(ptns[0]);
   static size_t counters[n_ptns] = {0};


   #pragma omp for schedule(dynamic, 1) nowait
   for (int i = 0; i < n_ptns; ++i)
   {
      typedef regex_iterator<CIte_Data_T> RI_T;

      // static regex
      Regex_Data_T const& regex(ptns[i].second);
      counters[i] = distance(   RI_T(input.begin(), input.end(), regex), RI_T()   );
   }

   // we want the last thread, reaching this code block, to print result
   static size_t thread_passed = 0;
   if (__sync_add_and_fetch(&thread_passed, 1) == static_cast<size_t>(omp_get_num_threads()))
   {
      boost::format format("%1% %2%\n");

      for (int i = 0; i < n_ptns; ++i)
      {
         format % ptns[i].first % counters[i];
         result += format.str();
      }
      thread_passed = 0;
   }
}


struct IUB
{
   PChar_T   iub;
   int      len;
};

IUB const iub_table[] = 
{
   {0}, 
   {"(c|g|t)",   7}, 
   {0}, 
   {"(a|g|t)",   7}, 
   {0}, {0}, {0}, 
   {"(a|c|t)",   7}, 
   {0}, {0}, 
   {"(g|t)",   5}, 
   {0}, 
   {"(a|c)",   5}, 
   {"(a|c|g|t)",   9}, 
   {0}, {0}, {0}, 
   {"(a|g)",   5}, 
   {"(c|t)",   5}, 
   {0}, {0}, 
   {"(a|c|g)",   7}, 
   {"(a|t)",   5}, 
   {0}, 
   {"(c|t)",   5}
};
int const n_iub = sizeof(iub_table)/sizeof(iub_table[0]);


struct Formatter
{
   template<typename Match, typename Out>
   Out 
   operator()(Match const &m, Out o) const
   {
      IUB const &i (iub_table[ *m[0].first - 'A' ]);
      return copy(i.iub, i.iub + i.len, o);
   }
};


void Replace_Patterns(Data_T const& input, size_t &replace_len)
{
   #pragma omp single nowait
   {
      Data_T         output;
      output.reserve   (input.size() + (input.size() >> 1));   // size * 1.5

      regex_replace(   OIte_Data_T(output), 
                  input.begin(), input.end(), 

                  // "[BDHKMNRSVWY]"
                  Regex_Data_T( (x::set='B','D','H','K','M','N','R','S','V','W','Y') ), 

                  Formatter()   );

      replace_len = output.size();
   }
}



// Detect single - multi thread benchmark
int 
GetThreadCount()
{
   cpu_set_t cs;
   CPU_ZERO(&cs);
   sched_getaffinity(0, sizeof(cs), &cs);

   int count = 0;
   for (int i = 0; i < 16; ++i)
   {
      if (CPU_ISSET(i, &cs))
      ++count;
   }
   return count;
}


int 
main()
{
   size_t initial_length = 0;
   size_t striped_length = 0;
   size_t replace_length = 0;
   
   Data_T input;
   
   striped_length = ReadInput_StripHeader (initial_length, input);

   std::string match_result;
   #pragma omp parallel default(shared) num_threads(GetThreadCount())
   {
      Count_Patterns   (input, match_result);
      Replace_Patterns(input, replace_length);
   }

   std::cout << (   boost::format("%1%\n%2%\n%3%\n%4%\n") 
      % match_result 
      % initial_length % striped_length % replace_length );

   return 0;
}

