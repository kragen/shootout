/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by K P anonymous
 */

package main

import (
   "bufio"
   "bytes"
   "fmt"
   "io/ioutil"
   "os"
   "runtime"
   "sort"
   "sync"
)

type entry struct {
   bs    []byte
   value int
   next  *entry
}

const tabSize = 2 << 16

type Table struct {
   count int
   items [tabSize]*entry
}

func (bt *Table) Dump() []kNuc {
   res := make([]kNuc, bt.count)
   i := 0
   for _, e := range bt.items {
      for e != nil {
         res[i] = kNuc{name: e.bs, count: e.value}
         i++
         e = e.next
      }
   }
   return res
}

func hashbytes(seg []byte) uint {
   l := len(seg)
   h := uint(l)
   for i := 0; i < l; i++ {
      h = h*131 + uint(seg[i])
   }
   return h
}

func (bt *Table) get(bs []byte) *entry {
   ind := hashbytes(bs) % uint(tabSize)
   e := bt.items[ind]
   if e == nil {
      r := &entry{bs, 0, nil}
      bt.count++
      bt.items[ind] = r
      return r
   }
   for {
      if bytes.Equal(e.bs, bs) {
         return e
      }
      if e.next == nil {
         r := &entry{bs, 0, nil}
         bt.count++
         e.next = r
         return r
      }
      e = e.next
   }
   return nil
}

var (
   tables [8]Table
   ti     = 0
   tmux   sync.Mutex
)

func newTable() *Table {
   tmux.Lock()
   t := &tables[ti]
   ti++
   tmux.Unlock()
   return t
}

func count(data []byte, n int) *Table {
   counts := newTable()
   top := len(data) - n
   for i := 0; i <= top; i++ {
      counts.get(data[i:i+n]).value++
   }
   return counts
}

func countOne(data []byte, s []byte) int {
   return count(data, len(s)).get(s).value
}

type kNuc struct {
   name  []byte
   count int
}

type kNucArray []kNuc

func (kn kNucArray) Len() int      { return len(kn) }
func (kn kNucArray) Swap(i, j int) { kn[i], kn[j] = kn[j], kn[i] }
func (kn kNucArray) Less(i, j int) bool {
   if kn[i].count == kn[j].count {
      return bytes.Compare(kn[i].name, kn[j].name) < 0 // sort down
   }
   return kn[i].count > kn[j].count
}

func printKnucs(a kNucArray) {
   sum := 0
   for _, kn := range a {
      sum += kn.count
   }
   for _, kn := range a {
      fmt.Printf("%s %.3f\n", kn.name, 100*float64(kn.count)/float64(sum))
   }
   fmt.Print("\n")
}

func main() {
   runtime.GOMAXPROCS(4)
   in := bufio.NewReader(os.Stdin)
   three := []byte(">THREE ")
   for {
      line, err := in.ReadSlice('\n')
      if err != nil {
         panic(err)
      }
      if bytes.HasPrefix(line, three) {
         break
      }
   }
   data, err := ioutil.ReadAll(in)
   if err != nil {
      panic(err)
   }
   // delete the newlines and convert to upper case
   j := 0
   for i := 0; i < len(data); i++ {
      if data[i] != '\n' {
         data[j] = data[i] &^ ' ' // upper case
         j++
      }
   }
   str := data[0:j]

   var wg sync.WaitGroup
   async := func(fn func()) {
      wg.Add(1)
      go func() {
         fn()
         wg.Done()
      }()
   }

   var arrs [2]kNucArray
   async(func() {
      arrs[0] = count(str, 1).Dump()
      sort.Sort(arrs[0])
   })
   async(func() {
      arrs[1] = count(str, 2).Dump()
      sort.Sort(arrs[1])
   })

   interests := []string{"GGT", "GGTA", "GGTATT", "GGTATTTTAATT", "GGTATTTTAATTTATAGT"}
   results := make([]string, len(interests))
   for i, s := range interests {
      s, i := s, i
      async(func() {
         results[i] = fmt.Sprintf("%d\t%s", countOne(str, []byte(s)), s)
      })
   }
   wg.Wait()
   printKnucs(arrs[0])
   printKnucs(arrs[1])
   for _, rc := range results {
      fmt.Println(rc)
   }
}
