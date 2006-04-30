/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Isaac Gouy

   converted to D by Dave Fladebo
   compile: dmd -O -inline -release pidigits.d gmp4d/gmppool.d gmp4d/mpz.d -Igmp4d -L-lgmp

   GMP for D library provided by Ben Hinkle (http://home.comcast.net/~benhinkle/gmp-d/)
   Original D code optimized by Ben Hinkle to recycle GMP objects.
*/

import std.conv, std.stdio, std.string, mpz, gmp;

const int L = 10;

void main(char[][] args)
{
    int n = args.length > 1 ? atoi(args[1]) : 1;
    int j = 0;

    PiDigitSpigot digits = new PiDigitSpigot();

    while(n > 0){
       if(n >= L){
          for (int i = 0; i < L; i++) writef("%d",digits.next());
          j += L;
       } else {
          for (int i = 0; i < n; i++) writef("%d",digits.next());
          for (int i = n; i < L; i++) writef(" ");
          j += n;
       }
       writef("\t:"); writefln("%d",j);
       n -= L;
    }
}

class PiDigitSpigot
{
private:
    Transformation z, x, inverse;

public:
    this()
    {
        z = new Transformation(1,0,0,1);
        x = new Transformation(0,0,0,0);
        inverse = new Transformation(0,0,0,0);
    }

    int next()
    {
        int y = digit();
        if(isSafe(y))
        {
            Transformation oldz = z;
            z = produce(y);
            oldz.recycle();
            return y;
        } else {
            Transformation oldz = z;
            z = consume( x.next() );
            oldz.recycle();
            return next();
        }
    }

    int digit()
    {
        return z.extract(3);
    }

    bool isSafe(int digit)
    {
        return digit == z.extract(4);
    }

    Transformation produce(int i)
    {
        return (inverse.qrst(10,-10*i,0,1)).compose(z);
    }

    Transformation consume(Transformation a){
        return z.compose(a);
    }
}

class Transformation
{
private:
    alias mpz BigInteger;
    BigInteger q, r, s, t;
    int k;

public:
    this(int q, int r, int s, int t)
    {
        this.q = new BigInteger(q,Recycle.Temp);
        this.r = new BigInteger(r,Recycle.Temp);
        this.s = new BigInteger(s,Recycle.Temp);
        this.t = new BigInteger(t,Recycle.Temp);
        k = 0;
    }

    this(BigInteger q_, BigInteger r_, BigInteger s_, BigInteger t_)
    {
        q = q_;
        r = r_;
        s = s_;
        t = t_;
        k = 0;
    }

    void recycle() 
    {
        mpzpool.recycle(q);
        mpzpool.recycle(s);
        mpzpool.recycle(r);
        mpzpool.recycle(t);
    }
  
    Transformation next()
    {
        k++;
        q.si = k;
        r.si = 4 * k + 2;
        s.si = 0;
        t.si = 2 * k + 1;
        return this;
    }

    int extract(int j)
    {
        return atoi(((q * j + r) / (s * j + t)).toString);
    }

    Transformation qrst(int q_, int r_, int s_, int t_)
    {
        q.si = q_;
        r.si = r_;
        s.si = s_;
        t.si = t_;
        k = 0;
        return this;
    }

    Transformation compose(Transformation a)
    {
        mpz tq = (q * a.q).save;
        mpz tr = ((q * a.r) + (r * a.t)).save;
        mpz ts = ((s * a.q) + (t * a.s)).save;
        mpz tt = ((s * a.r) + (t * a.t)).save;
        return new Transformation(tq,tr,ts,tt);
    }
}
