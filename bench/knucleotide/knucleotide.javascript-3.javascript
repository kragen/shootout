/*
The Computer Language Benchmarks Game
http://shootout.alioth.debian.org/
Contributed by Matthew Wilson
*/

var s="";while(!/^>TH/.test(readline()));for(var i;i=readline();s+=i);
var z,o={"ggt":3,"ggta":4,"ggtatt":6,"ggtattttaatt":12,"ggtattttaatttatagt":18};
function F(l,n,t){for(var m,i=0;i<n;++t[m=s.substring(i,++i+l-1)]||(t[m]=1));}
for(var l=1;l<3;++l) {
  var j,n=s.length-l+1,f={},keys=Array(Math.pow(4,l)),k,i=-1; F(l,n,f);
  for(k in f) keys[++i] = k; keys.sort(function(a, b){ return f[b] - f[a] });
  for(j=0;j<=i;print(keys[j].toUpperCase(),(f[keys[j++]]*100/n).toFixed(3)));
  print();
}
for(var i in o)F(z=o[i],s.length-z+1,z={}),print((z[i]||0)+"\t"+i.toUpperCase())
