/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by The Go Authors.
 */

package main

import (
   "bufio"
   "bytes"
   "fmt"
   "io/ioutil"
   "os"
   "sort"
   "strings"
)

var in *bufio.Reader

func count(data string, n int) map[string]int {
   counts := make(map[string]int)
   top := len(data) - n
   for i := 0; i <= top; i++ {
      s := data[i : i+n]
      if k, ok := counts[s]; ok {
         counts[s] = k + 1
      } else {
         counts[s] = 1
      }
   }
   return counts
}

func countOne(data string, s string) int {
   counts := count(data, len(s))
   if i, ok := counts[s]; ok {
      return i
   }
   return 0
}


type kNuc struct {
   name   string
   count   int
}

type kNucArray []kNuc

func (kn kNucArray) Len() int      { return len(kn) }
func (kn kNucArray) Swap(i, j int)   { kn[i], kn[j] = kn[j], kn[i] }
func (kn kNucArray) Less(i, j int) bool {
   if kn[i].count == kn[j].count {
      return kn[i].name > kn[j].name   // sort down
   }
   return kn[i].count > kn[j].count
}

func sortedArray(m map[string]int) kNucArray {
   kn := make(kNucArray, len(m))
   i := 0
   for k, v := range m {
      kn[i].name = k
      kn[i].count = v
      i++
   }
   sort.Sort(kn)
   return kn
}

func print(m map[string]int) {
   a := sortedArray(m)
   sum := 0
   for _, kn := range a {
      sum += kn.count
   }
   for _, kn := range a {
      fmt.Printf("%s %.3f\n", kn.name, 100*float64(kn.count)/float64(sum))
   }
}

func main() {
   in = bufio.NewReader(os.Stdin)
   three := strings.Bytes(">THREE ")
   for {
      line, err := in.ReadSlice('\n')
      if err != nil {
         fmt.Fprintln(os.Stderr, "ReadLine err:", err)
         os.Exit(2)
      }
      if line[0] == '>' && bytes.Equal(line[0:len(three)], three) {
         break
      }
   }
   data, err := ioutil.ReadAll(in)
   if err != nil {
      fmt.Fprintln(os.Stderr, "ReadAll err:", err)
      os.Exit(2)
   }
   // delete the newlines and convert to upper case
   j := 0
   for i := 0; i < len(data); i++ {
      if data[i] != '\n' {
         data[j] = data[i] &^ ' '   // upper case
         j++
      }
   }
   str := string(data[0:j])

   print(count(str, 1))
   fmt.Print("\n")

   print(count(str, 2))
   fmt.Print("\n")

   interests := []string{"GGT", "GGTA", "GGTATT", "GGTATTTTAATT", "GGTATTTTAATTTATAGT"}
   for _, s := range interests {
      fmt.Printf("%d\t%s\n", countOne(str, s), s)
   }
}
