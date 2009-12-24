/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by Roger Peppe
 * modified by Arvindh Rajesh Tamilmani
 */

package main

import (
   "fmt"
   "flag"
   "strconv"
)

const (
   blue   = iota
   red
   yellow
   ncol
)

var complement = [...]int{
   red | red<<2: red,
   red | yellow<<2: blue,
   red | blue<<2: yellow,
   yellow | red<<2: blue,
   yellow | yellow<<2: yellow,
   yellow | blue<<2: red,
   blue | red<<2: yellow,
   blue | yellow<<2: red,
   blue | blue<<2: blue,
}

var colname = [...]string{
   blue: "blue",
   red: "red",
   yellow: "yellow",
}

// information about the current state of a creature.
type info struct {
   colour   int   // creature's current colour.
   name   int   // creature's name.
}

// exclusive access data-structure kept inside meetingplace.
// if mate is nil, it indicates there's no creature currently waiting
// otherwise the creature's info is stored in info, and
// it is waiting to receive its mate's information on the mate channel.
type rendez struct {
   n   int      // current number of encounters.
   mate   chan<- info   // creature waiting when non-nil.
   info   info      // info about creature waiting.
}

// result sent by each creature at the end of processing.
type result struct {
   met   int
   same   int
}

type creature struct {
   info
   result
}

var n = 600

func main() {
   flag.Parse()
   if flag.NArg() > 0 {
      n, _ = strconv.Atoi(flag.Arg(0))
   }

   for c0 := 0; c0 < ncol; c0++ {
      for c1 := 0; c1 < ncol; c1++ {
         fmt.Printf("%s + %s -> %s\n", colname[c0], colname[c1], colname[complement[c0|c1<<2]])
      }
   }
   fmt.Print("\n")

   pallmall([]int{blue, red, yellow})
   pallmall([]int{blue, red, yellow, red, yellow, blue, red, yellow, red, blue})
}

func pallmall(cols []int) {

   // invariant: meetingplace always contains a value unless a creature
   // is currently dealing with it (whereupon it must put it back).
   meetingplace := make(chan rendez, 1)
   meetingplace <- rendez{n: 0}

   ended := make(chan result)
   msg := ""
   for i, col := range cols {
      c := &creature{info{col, i}, result{}}
      go c.play(meetingplace, ended)
      msg += " " + colname[col]
   }
   fmt.Println(msg)
   tot := 0
   // wait for all results
   for _ = range cols {
      result := <-ended
      tot += result.met
      fmt.Printf("%v%v\n", result.met, spell(result.same, true))
   }
   fmt.Printf("%v\n\n", spell(tot, true))
}

func (self *creature) play(meetingplace chan rendez, ended chan result) {
   c0 := make(chan info)
   for {
      // get access to rendez data and decide what to do.
      switch r := <-meetingplace; {
      case r.n >= n:
      end:
         // no more meetings can be had.
         // inform other creatures.
         meetingplace <- rendez{n: r.n}
         // send our result data and exit.
         ended <- self.result
         return
      case r.mate != nil:
         // another creature is waiting for us.
         r.mate <- self.info
         self.meet(r.info)

         r.n++
         if r.n >= n {
            goto end
         }
         // more meetings can be had
         // hence fall through and wait for another creature.
         fallthrough
      case r.mate == nil:
         // wait for another creature to meet us.
         meetingplace <- rendez{r.n, c0, self.info}
         self.meet(<-c0)
      }
   }
}

func (self *creature) meet(mate info) {
   self.colour = complement[self.colour|mate.colour<<2]
   if self.name == mate.name {
      self.same++
   }
   self.met++
}

var digits = [...]string{"zero", "one", "two", "three",
                         "four", "five", "six", "seven", "eight", "nine"}

func spell(n int, required bool) string {
   if n == 0 && !required {
      return ""
   }
   return spell(n/10, false) + " " + digits[n%10]
}
