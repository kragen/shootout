/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by K P anonymous
 */

package main

import (
   "bufio"
   "bytes"
   "sync"
   "fmt"
   "io/ioutil"
   "os"
   "sort"
   "runtime"
)

type byteseg struct {
   hash  uint
   slice []byte
}

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
   ind := 0
   for _, e := range bt.items {
      for e != nil {
         res[ind] = kNuc{name: e.bs, count: e.value}
         ind++
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

func eqbytes(a, b []byte) bool {
   l := len(a)
   if l != len(b) {
      return false
   }
   i := 0
   for ; i < l && a[i] == b[i]; i++ {
   }
   return i == l
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
      if eqbytes(e.bs, bs) {
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

func (bt *Table) Increment(bs []byte) {
   bt.get(bs).value++
}

func (bt *Table) Lookup(bs []byte) int {
   return bt.get(bs).value
}

var tables [8]Table
var ti = 0
var tmux sync.Mutex

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
      counts.Increment(data[i : i+n])
   }
   return counts
}

func countOne(data []byte, s []byte) int {
   return count(data, len(s)).Lookup(s)
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

func sortedArray(m *Table) kNucArray {
   kn := kNucArray(m.Dump())
   sort.Sort(kn)
   return kn
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
         data[j] = data[i] &^ ' ' // upper case
         j++
      }
   }
   str := data[0:j]

   var arr1, arr2 kNucArray
   countsdone := make(chan bool, 2)
   go func() {
      arr1 = sortedArray(count(str, 1))
      countsdone <- true
   }()
   go func() {
      arr2 = sortedArray(count(str, 2))
      countsdone <- true
   }()

   interests := []string{"GGT", "GGTA", "GGTATT", "GGTATTTTAATT", "GGTATTTTAATTTATAGT"}
   results := make([]chan string, len(interests))
   for i, s := range interests {
      ch := make(chan string, 1)
      results[i] = ch
      go func(result chan string, ss string) {
         result <- fmt.Sprintf("%d\t%s\n", countOne(str, []byte(ss)), ss)
      }(ch, s)
   }
   <-countsdone
   <-countsdone
   printKnucs(arr1)
   printKnucs(arr2)
   for _, rc := range results {
      fmt.Print(<-rc)
   }
}
