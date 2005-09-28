/* The Great Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Isaac Gouy */

function A(i,j){
   return 1.0/((i+j)*(i+j+1)/2 +i+1);
}

function Av(n,v){
   var t = Array(n);
   for (var i=0; i<n; i++){
      t[i] = 0;
      for (var j=0; j<n; j++) t[i] += A(i,j)*v[j];
   }
   return t;
}

function Atv(n,v){
   var t = Array(n);
   for (var i=0;i<n;i++){
      t[i] = 0;
      for (var j=0; j<n; j++) t[i] += A(j,i)*v[j];
   }
   return t;
}

function AtAv(n,v){
   return Atv(n, Av(n,v));
}


var n = arguments[0];
var u = Array(n);
for (var i=0; i<n; i++) u[i] =  1.0;

// 20 steps of the power method
var v = Array(n);
for (var i=0; i<10; i++){
   v = AtAv(n,u);
   u = AtAv(n,v);
}

var vBv = 0, vv = 0;
for (var i=0; i<n; i++){
   vBv += u[i]*v[i];
   vv  += v[i]*v[i];
}
print( (Math.sqrt(vBv/vv)).toFixed(9) );
