// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
//
// contributed by Ian Osgood

function A(i,j) {
  return 1/((i+j)*(i+j+1)/2+i+1);
}

function Au(u,v) {
  for (var i in u) {
    var t = 0;
    for (var j in u)
      t += A(i,j) * u[j];
    v[i] = t;
  }
}

function Atu(u,v) {
  for (var i in u) {
    var t = 0;
    for (var j in u)
      t += A(j,i) * u[j];
    v[i] = t;
  }
}

function AtAu(u,v,w) {
  Au(u,w);
  Atu(w,v);
}

function norm(n) {
  var i, u=[], v=[], w=[], vv=0, vBv=0;
  for (i=0; i<n; i++) {
    u[i] = 1; v[i] = w[i] = 0; 
  }
  for (i=0; i<10; i++) {
    AtAu(u,v,w);
    AtAu(v,u,w);
  }
  for (i in u) {
    vBv += u[i]*v[i];
    vv  += v[i]*v[i];
  }
  return Math.sqrt(vBv/vv);
}

print(norm(arguments[0]).toFixed(9));
