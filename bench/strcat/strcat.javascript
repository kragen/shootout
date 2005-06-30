// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
//
// contributed by David Hedbor
// modified by Isaac Gouy

var n = arguments[0];
var str = new String("");
while(n--){ str.append("hello\n"); }
print(str.length);
