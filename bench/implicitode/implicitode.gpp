// -*-c++-*-
// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
//
// contributed by Sebastien Loisel
//
// OVERVIEW: In this test, we solve an ordinary differential equation
//    u'=f(t,u)
// using the Trapezoid numerical method, which can be written as
//    (u[k+1]-u[k])=(f(t[k],u[k])+f(t[k]+dt,u[k+1]))*dt/2,
// where t[k], u[k], dt and the function f are known and u[k+1] is the
// unknown.
//
// Since u[k+1] appears on both sides of the equation, we use an iterative
// solver called the newton iteration to compute u[k+1]. The newton iteration
// computes the solution to
//    h(x)=0
// where h is a known function and x is the unknown 0 of h, using the method
//    x[k+1]=x[k]-f(x[k])/f'(x[k]).
// Here, f' denotes the derivative of f.
//
// To compute f' from the definition of f alone, we use a technique called
// automatic differentiation. This works by replacing all floating point
// variables by a special type we call ad (for automatic differentiation.)
// If the python program for f is called with parameter x of type ad,
// it will do the same work as if it were called with the equivalent parameter
// of type floating point, but will also return f'. That's why it's called
// "automatic."
//
// To shake things up, we also have another type, fl (for "float") which
// works exactly like a double precision floating point, but with much
// less precision.

#include <math.h>
#include <iostream>
#include <complex>
#include <stdio.h>
#include <string>

using namespace std;
#define op operator

template <class F> F sqr(const F &x) { return x*x; }
template <class F> F pow(const F &x, int i)
{ if(i<=0) return F(1); if(i&1) return x*pow(x,i-1); return sqr(pow(x,i/2)); }

struct fl
{
  double a;
  fl() : a(0) {}
  void set(const double x)
  {
    if(x==0) { a=0; return; }
    int k=(int)log(fabs(x));
    a=round(x*exp(-k+6.0))*exp(k-6.0);
  }
  fl(int x) { set(x); }
  fl(double x) { set(x); }
  fl op +(const fl &y) const { return fl(a+y.a); }
  fl &op +=(const fl &y) { *this=(*this)+y; return *this; }
  fl op -(const fl &y) const { return fl(a-y.a); }
  fl &op -=(const fl &y) { *this=(*this)-y; return *this; }
  fl op *(const fl &y) const { return fl(a*y.a); }
  fl op /(const fl &y) const { return fl(a/y.a); }
};

template <class F>
struct ad
{
  F x,dx;
  ad() : x(0), dx(0) {}
  ad(int y) : x(y), dx(0) {}
  ad(const F &y, F dy=F(0)) : x(y), dx(dy) {}
  ad op +(const ad &y) const { return ad(x+y.x,dx+y.dx); }
  ad op -(const ad &y) const { return ad(x-y.x,dx-y.dx); }
  ad op *(const ad &y) const { return ad(x*y.x,dx*y.x+x*y.dx); }
  ad op / (const ad &y) const { return ad(x/y.x,(dx*y.x-x*y.dx)/(y.x*y.x)); }
};

template <class F> F rat(const F &x)
{ return (x*F(2)+pow(x,2)*F(3)+pow(x,6)*F(7)+pow(x,11)*F(5)+F(1))/
    (x*F(5)-pow(x,3)*F(6)-pow(x,7)*F(3)+F(2)); }

template <class F, class fun>
F newton(F x0, int n, fun &g)
{
  ad<F> val; int i;
  for(i=0;i<n;i++) { val=g(ad<F>(x0,F(1))); x0=x0-val.x/val.dx; }
  return x0;
}

template <class F> struct sqrfinder
{ ad<F> op () (const ad<F> &z) { return sqr(z)-ad<F>(2); } };
template <class F> struct ratfinder
{ ad<F> op () (const ad<F> &z) { return rat(z); } };

template <class F, class fun>
struct trapezoid_method_rooter
{
  fun g;
  ad<F> g0;
  F y0,t0,t1;
  trapezoid_method_rooter(fun &G, const F &Y0, const F &T0, const F &T1) :
    g(G),y0(Y0),t0(T0),t1(T1),g0(G(T0,Y0)) {}
  ad<F> op () (const ad<F> &y1)
  { return (g(ad<F>(t1),y1)+g0)*((t1-t0)/F(2))+ad<F>(y0)-y1; }
};

template <class F, class fun>
F trapezoid_method(F t0, const F &dt, F y0, fun &g, int numsteps)
{
  int i;
  for(i=0;i<numsteps;i++)
    {
      trapezoid_method_rooter<F,fun> solver(g,y0,t0,t0+dt);
      y0=newton(y0,10,solver); t0=t0+dt;
    }
  return y0;
}

string pr(double x) { char s[100]; sprintf(s,"%.12e",x); return string(s); }
string pr(const fl &x) {
  char s[100];
  sprintf(s,"%.2e",x.a);
  return string(s);
}

template <class F>
string pr(const complex<F> &x) { return pr(real(x))+" "+pr(imag(x)); }
template <class F>
ostream & op <<(ostream &o, const ad<F> &x) {
  return o<<pr(x.x)<<" "<<pr(x.dx);
}

template <class F>
struct sqrintegrand { F op () (const F &t, const F &y) { return sqr(y); } };
template <class F>
struct ratintegrand { F op () (const F &t, const F &y) { return rat(y)-t; } };

template <class F>
void integrate_functions(F x0, int n)
{
  sqrintegrand<ad<F> > i1;
  ratintegrand<ad<F> > i2;
  cout<<"i1 "<<pr(trapezoid_method(F(1),F(1)/F(n),x0,i1,n))
    <<"\ni2 "<<pr(trapezoid_method(F(1),F(1)/F(n),x0,i2,n))<<"\n";
}

int main(int argc, char *argv[])
{
  int N=(argc==2)?(atoi(argv[1])):50;
  sqrfinder<double> mysqrt; ratfinder<double> myratt;
  double x(newton(-1.0,6,myratt));
  cout<<"rational_taylor_series: "<<rat(ad<double>(0.25,1.0))<<endl;
  cout<<"newton-sqrt_2: "<<pr(newton(1.0,10,mysqrt))<<endl;
  cout<<"newton-rat: "<<pr(x)<<endl;
  integrate_functions(0.02,N*4);
  integrate_functions(fl(0.02),N);
  integrate_functions(complex<double>(0.02,0.02),N);
  integrate_functions(complex<fl>(fl(0.02),fl(0.02)),N);
  return 0;
}
