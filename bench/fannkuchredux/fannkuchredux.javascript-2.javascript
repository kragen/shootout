/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy
   modified by Matthew Wilson 
*/

function fannkuch(n) {
   var check = 0;
   var perm = Array(n);
   var perm1 = Array(n);
   var count = Array(n);
   var maxPerm = Array(n);
   var maxFlipsCount = 0;
   var m = n - 1;
   var permCount = 0;
   var checksum = 0;

   for (var i = 0; i < n; i++) perm1[i] = i;
   var r = n;

   while (true) {

      while (r != 1) { count[r - 1] = r; r--; }

      for (var i = 0; i < n; i++) perm[i] = perm1[i];

      var flipsCount = 0;
      var k;

      while (!((k = perm[0]) == 0)) {
         var k2 = (k + 1) >> 1;
         for (var i = 0; i < k2; i++) {
            var temp = perm[i]; perm[i] = perm[k - i]; perm[k - i] = temp;
         }
         flipsCount++;
      }

      if (flipsCount > maxFlipsCount) {
         maxFlipsCount = flipsCount;
         for (var i = 0; i < n; i++) maxPerm[i] = perm1[i];
      }

      checksum += permCount%2 == 0 ? flipsCount : -flipsCount; 

      while (true) {
         if (r == n){
            print(checksum);
            return maxFlipsCount;
         }

         var perm0 = perm1[0];
         var i = 0;
         while (i < r) {
            var j = i + 1;
            perm1[i] = perm1[j];
            i = j;
         }
         perm1[r] = perm0;

         count[r] = count[r] - 1;
         if (count[r] > 0) break;
         r++;
      }

      permCount++;
      if (permCount == 1048576){ permCount = 0; }
   }
}

var n = 1*arguments[0]*1;
print("Pfannkuchen(" + n + ") = " + fannkuch(n));
