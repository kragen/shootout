/** \file mpf.d
 * \brief Object wrapper for mpf_t
 */

/* Copyright Ben Hinkle 2003-2005 benhinkle@gmail.com
 * http://home.comcast.net/~benhinkle 
 *
 * Permission to use, copy, modify, distribute and sell this software
 * and its documentation for any purpose is hereby granted without fee,
 * provided that the above copyright notice appear in all copies and
 * that both that copyright notice and this permission notice appear
 * in supporting documentation.  Author makes no representations about
 * the suitability of this software for any purpose. It is provided
 * "as is" without express or implied warranty.
 */

import gmp;
import gmppool;
import mpz;

private import std.string;

//debug = MPF_DEBUG;

/** \class mpf
 * \brief Object wrapper for mpf_t
 *
 * This class is a wrapper around the mpf structure and functions
 * from the gmp.d interface. Arithmetic operations like add, mult,
 * etc allocate a new object and call the low-level gmp function.
 * The underlying mpf_t struct is public and can be directly passed
 * to the gmp.d interface.
 */
class mpf {

  mpf_t mp;       ///< low-level mpf_t data structure
  int recycle;    ///< flag that value is temporary

  /** Construct mpf object and initialize to zero.*/
  this() {
    mpf_init(mp);
  }

  /** Construct mpf object and initialize.
   * \param y the value to initialize to
   */
  this(mpf y, Recycle recycle = Recycle.Never) {
    mpf_init_set(mp,y.mp);
    this.recycle = recycle;
  }

  /** Construct mpf object and initialize.
   * \param y the value to initialize to
   */
  this(double y, Recycle recycle = Recycle.Never) {
    mpf_init_set_d(mp,y);
    this.recycle = recycle;
  }

  /** Construct mpf object and initialize.
   * \param y the value to initialize to
   */
  this(gmp_ulong y, Recycle recycle = Recycle.Never) {
    mpf_init_set_ui(mp,y);
    this.recycle = recycle;
  }

  /** Construct mpf object and initialize.
   * \param y the value to initialize to
   */
  this(int y, Recycle recycle = Recycle.Never) {
    mpf_init_set_si(mp,cast(gmp_long)y);
    this.recycle = recycle;
  }

  /** Construct mpf object and initialize.
   * \param y the value to initialize to
   * \param base the base of the digits in y
   */
  this(char[] y,int base, Recycle recycle = Recycle.Never) {
    mpf_init_set_str(mp,toStringz(y),base);
    this.recycle = recycle;
  }

  /** Property to mark an mpf object as no longer temporary. It 
   * will not be recycled after being used in an arithmetic operation.
   * \return this
   */
  final mpf save() {
    recycle |= Recycle.Temp;
    return this;
  }
  
  private static this() {
    mpfpool = new TGmpPool!(mpf);
    mpfpool.clearAll();
  }
  
  /** Compute absolute value
   * \param x the value to take the absolute value of
   * \return the absolute value of x
   */
  final static mpf abs(mpf x) {
    mpf res = mpfpool.allocate();
    mpf_abs(res.mp,x.mp);
    debug (MPF_DEBUG) {
      gmp_printf("abs(%Fg) got %Fg\n",&x.mp,&res.mp);
    }
    res.recycle = (x.recycle & Recycle.Never);
    if (x.recycle == Recycle.Self)
      mpfpool.recycle(x);
    return res;
  }

  /** Compute sum
   * \param y the value to add to
   * \return the sum of this and y.
   */
  final mpf opAdd(int y) {
    mpf res = mpfpool.allocate();
    if (y >= 0)
      mpf_add_ui(res.mp,mp,cast(gmp_ulong)y);
    else {
      mpf_sub_ui(res.mp,mp,cast(gmp_ulong)(-y));
    }
    debug (MPF_DEBUG) {
      gmp_printf("%Fg / %d got %Fg\n",&mp,y,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpfpool.recycle(this);
    return res;
  }

  /** Compute sum
   * \param y the value to add to
   * \return the sum of this and y.
   */
  final mpf opAddAssign(int y) {
    if (y >= 0)
      mpf_add_ui(mp,mp,cast(gmp_ulong)y);
    else {
      mpf_sub_ui(mp,mp,cast(gmp_ulong)(-y));
    }
    debug (MPF_DEBUG) {
      gmp_printf(" /= %d got %Fg\n",y,&mp);
    }
    return this;
  }

  /** Compute sum
   * \param y the value to add to
   * \return the sum of this and y.
   */
  final mpf opAdd(mpf y) {
    mpf res = mpfpool.allocate();
    mpf_add(res.mp,mp,y.mp); 
    debug (MPF_DEBUG) {
      gmp_printf("%Fg + %Fg got %Fg\n",&mp,&y.mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never)|(y.recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpfpool.recycle(this);
    if (y.recycle == Recycle.Self)
      mpfpool.recycle(y);
    return res;
  }

  /** Add and assign (+=)
   * \param y the value to add to
   * \return resulting value
   */
  final mpf opAddAssign(mpf y) {
    mpf_add(mp,mp,y.mp);
    debug (MPF_DEBUG) {
      gmp_printf(" += %Fg got %Fg\n",&y.mp,&mp);
    }
    if (y.recycle == Recycle.Self)
      mpfpool.recycle(y);
    return this;
  }

  /** Approximately equal
   * \param y the value to compare to
   * \param n the precision to compare in bits
   * \return true if object equals y up to precision
   */
  final int approx(mpf y, int n) {
    int res = mpf_eq(mp,y.mp,cast(gmp_ulong)n);
    debug (MPF_DEBUG) {
      gmp_printf("eq(%Fg,%Fg,%d) got %d\n",&mp,&y.mp,n,res);
    }
    if (recycle == Recycle.Self)
      mpfpool.recycle(this);
    if (y.recycle == Recycle.Self)
      mpfpool.recycle(y);
    return res;
  }

  /** Comparison
   * \param y the value to compare to
   * \return -1 if less, 0 is equal and 1 is more
   */
  final int opCmp(int y) {
    int res = mpf_cmp_si(mp,cast(gmp_long)y);
    debug (MPF_DEBUG) {
      gmp_printf("cmp(%Fg,%d) got %d\n",&mp,y,res);
    }
    if (recycle == Recycle.Self)
      mpfpool.recycle(this);
    return res;
  }

  /** Comparison
   * \param y the value to compare to
   * \return -1 if less, 0 is equal and 1 is more
   */
  final int opCmp(double y) {
    int res = mpf_cmp_d(mp,y);
    debug (MPF_DEBUG) {
      gmp_printf("cmp(%Fg,%g) got %d\n",&mp,y,res);
    }
    if (recycle == Recycle.Self)
      mpfpool.recycle(this);
    return res;
  }

  /** Comparison
   * \param y the value to compare to
   * \return -1 if less, 0 is equal and 1 is more
   */
  final int opCmp(mpf y) {
    int res = mpf_cmp(mp,y.mp);
    debug (MPF_DEBUG) {
      gmp_printf("cmp(%Fg,%Fg) got %d\n",&mp,&y.mp,res);
    }
    if (recycle == Recycle.Self)
      mpfpool.recycle(this);
    if (y.recycle == Recycle.Self)
      mpfpool.recycle(y);
    return res;
  }

  /** Divide
   * \param y the value to divide
   * \return the quotient of this and y, truncated
   */
  final mpf opDiv(mpf y) {
    mpf res = mpfpool.allocate();
    mpf_div(res.mp,mp,y.mp);
    debug (MPF_DEBUG) {
      gmp_printf("%Fg / %Fg got %Fg\n",&mp,&y.mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never)|(y.recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpfpool.recycle(this);
    if (y.recycle == Recycle.Self)
      mpfpool.recycle(y);
    return res;
  }

  /** Divide and assign (/=)
   * \param y the value to divide
   * \return resulting value
   */
  final mpf opDivAssign(mpf y) {
    mpf_div(mp,mp,y.mp);
    debug (MPF_DEBUG) {
      gmp_printf(" /= %Fg got %Fg\n",&y.mp,&mp);
    }
    return this;
  }

  /** Divide
   * \param y the value to divide
   * \return the quotient of this and y, truncated
   */
  final mpf opDiv(int y) {
    mpf res = mpfpool.allocate();
    if (y >= 0)
      mpf_div_ui(res.mp,mp,cast(gmp_ulong)y);
    else {
      mpf_div_ui(res.mp,mp,cast(gmp_ulong)(-y));
      mpf_neg(res.mp,res.mp);
    }
    debug (MPF_DEBUG) {
      gmp_printf("%Fg / %d got %Fg\n",&mp,y,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpfpool.recycle(this);
    return res;
  }

   /** Divide and assign (/=)
    * \param y the value to divide
    * \return resulting value
    */
   final mpf opDivAssign(int y) {
     if (y >= 0)
       mpf_div_ui(mp,mp,cast(gmp_ulong)y);
     else {
       mpf_div_ui(mp,mp,cast(gmp_ulong)(-y));
       mpf_neg(mp,mp);
     }
     debug (MPF_DEBUG) {
       gmp_printf(" /= %d got %Fg\n",y,&mp);
     }
     return this;
   }

  /** Equality
   * \param y the value to compare to
   * \return true if object equals y
   */
  final int opEquals(int y) {
    int res = (mpf_cmp_si(mp,cast(gmp_long)y) == 0); 
    debug (MPF_DEBUG) {
      gmp_printf("%Fg == %d got %d\n",&mp,y,res);
    }
    if (recycle == Recycle.Self)
      mpfpool.recycle(this);
    return res;
  }

  /** Equality
   * \param y the value to compare to
   * \return true if object equals y
   */
  final int opEquals(mpf y) {
    int res = (mpf_cmp(mp,y.mp) == 0); 
    debug (MPF_DEBUG) {
      gmp_printf("%Fg == %Fg got %d\n",&mp,&y.mp,res);
    }
    if (recycle == Recycle.Self)
      mpfpool.recycle(this);
    if (y.recycle == Recycle.Self)
      mpfpool.recycle(y);
    return res;
  }

  /** Convert to double
   * \return this as a double
   */
  final double get_d() {
    double res = mpf_get_d(mp);
    debug (MPF_DEBUG) {
      gmp_printf("get_d(%Fg) got %g\n",&mp,res);
    }
    if (recycle == Recycle.Self)
      mpfpool.recycle(this);
    return res;
  }

  /** Convert to string
   * \return this as a string
   */
  final char[] toString() {
    char[] res;
    char *resptr;
    mp_exp_t expv;
    resptr = mpf_get_str(null,&expv,10,0,mp);
    int n = strlen(resptr);
    char[] exps = .toString(expv);
    res = resptr[0..n] ~ "E" ~ exps;
    debug (MPF_DEBUG) {
      gmp_printf("toString(%Fg) got %.*s\n",&mp,res);
    }
    if (recycle == Recycle.Self)
      mpfpool.recycle(this);
    return res;
  }

  /** Multiply
   * \param y the value to multiply
   * \return the product of this and y.
   */
  final mpf opMul(mpf y) {
    mpf res = mpfpool.allocate();
    mpf_mul(res.mp,mp,y.mp);
    debug (MPF_DEBUG) {
      gmp_printf("%Fg * %Fg got %Fg\n",&mp,&y.mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never)|(y.recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpfpool.recycle(this);
    if (y.recycle == Recycle.Self)
      mpfpool.recycle(y);
    return res;
  }

  /** Multiply and assign (*=)
   * \param y the value to multiply
   * \return resulting value
   */
  final mpf opMulAssign(mpf y) {
    mpf_mul(mp,mp,y.mp);
    debug (MPF_DEBUG) {
      gmp_printf(" *= %Fg got %Fg\n",&y.mp,&mp);
    }
    if (y.recycle == Recycle.Self)
      mpfpool.recycle(y);
    return this;
  }

  /** Negative
   * \return the negative of this
   */
  final mpf opNeg() {
    mpf res = mpfpool.allocate();
    mpf_neg(res.mp,mp);
    debug (MPF_DEBUG) {
      gmp_printf("-%Fg got %Fg\n",&mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpfpool.recycle(this);
    return res;
  }

  /** Compute difference
   * \param y the value to subtract
   * \return the difference of this and y.
   */
  final mpf opSub(mpf y) {
    mpf res = mpfpool.allocate();
    mpf_sub(res.mp,mp,y.mp); 
    debug (MPF_DEBUG) {
      gmp_printf("%Fg - %Fg got %Fg\n",&mp,&y.mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never)|(y.recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpfpool.recycle(this);
    if (y.recycle == Recycle.Self)
      mpfpool.recycle(y);
    return res;
  }

  /** Subtract and assign (-=)
   * \param y the value to subtract
   * \return resulting value
   */
  final mpf opSubAssign(mpf y) {
    mpf_sub(mp,mp,y.mp);
    debug (MPF_DEBUG) {
      gmp_printf(" -= %Fg got %Fg\n",&y.mp,&mp);
    }
    if (y.recycle == Recycle.Self)
      mpfpool.recycle(y);
    return this;
  }

  unittest {
    mpf x = new mpf(3);
    assert(x+4 == 7);
    assert(4+x == 7);
    mpf x1 = new mpf(-7);
    assert(-x1 == 7);
    assert(x-new mpf(4) == -1);
    assert(new mpf(4)-x == 1);
    mpf y = new mpf(7U);
    mpf z = new mpf(10);
    assert(x+y == z);
    assert(y+x == 10);
    assert(x-y == -4);
    assert(y-x == -(x-y));
    assert(y-(new mpf(3))*x+x*y == 19); // 7-3*3+3*7 == 19
    assert((z/x).approx(new mpf(10.0/3),10));

    assert(y < 10);
    assert(y < z);
    assert(10 >= y);
    assert(x+y <= z);

    assert(-x == -3);
    assert(mpf.abs(-x) == 3);

    mpf a = new mpf("1234567890123456789012345678901234567890",10);
    mpf b = new mpf("123456789012345678901234567890123456789",10);
    assert(a.approx(b*(new mpf(10)),20));

    b = new mpf(y);
    assert(b == y);

    b += 3;
    assert(b == 10);
    b += b;
    assert(b == 20);
    assert(strcmp(b.toString(),"2E2")==0);
    assert(b.get_d() == 20.0);

    mpf c = new mpf(b);
    c /= 2;
    assert(c == 10);
    c *= c;
    assert(c == 100);
    c -= c/(new mpf(10));
    assert(c == 90);
  }
}

/** \var mpfpool 
 * The pool of mpf object instantiated from the template in gmppool.d
 */
static TGmpPool!(mpf) mpfpool;

/** Recycle any previous value in x, assign val and mark val
 * as not being a temporary object.
 * \param x the variable to assign to
 * \param val the value to assign to x
 */
void assign(inout mpf x, mpf val) {
  if (x !== null && x.recycle != Recycle.Never)
    mpfpool.recycle(x);
  val.recycle |= Recycle.Temp;
  x = val;
}

/** Set the precision for new mpf objects.
 * \param n the default precision in bits
 */
final void setPrecision(gmp_ulong n) {
  gmp_ulong oldn = mpf_get_default_prec();
  if (n != oldn) {
    mpf_set_default_prec(n);
    mpfpool.clearAll();
  }
}
  
/** Get the precision for new mpf objects.
 * \return the default precision in bits
 */
final gmp_ulong getPrecision() {
  return mpf_get_default_prec();
}
  
