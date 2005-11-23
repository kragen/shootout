/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Ian Osgood */

function fannkuch(n) {
   var perm = Array(n);
   for (var i = 0; i < n; i++) perm[i] = i+1;

   var r = n;
   var counts = Array(n);

   var m = n - 1;
   var maxFlipsCount = 0;
   var count = 0;

   do {
      // eliminate known bad pans
      if (perm[0] != 1 && perm[m] != n) {
         // pour the batter
         var pan = perm.slice(0);
         var i, j, flipsCount;

         // flip the pancakes
         for (flipsCount=0; (j = pan[0]) > 1; flipsCount++) {
            for (i=0, --j; i < j; i++, j--) {
               var t = pan[i]; pan[i] = pan[j]; pan[j] = t;
            }
         }
         if (flipsCount > maxFlipsCount) maxFlipsCount = flipsCount;
      }
      if (count < 30) { print(perm.join("")); ++count; }

      for ( ; r>1; r--) counts[r-1] = r;
      for ( ; r<n; r++) {
         // -roll(r)
         perm.splice(r, 0, perm.shift());

         // simulated recursion
         if (--counts[r] > 0) break;
      }
   } while (r < n);

   return maxFlipsCount;
}

var n = arguments[0];
print("Pfannkuchen(" + n + ") = " + fannkuch(n));