/** \file mpq.d
 * \brief Object wrapper for mpq_t
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

//debug = MPQ_DEBUG;

/** \class mpq
 * \brief Object wrapper for mpq_t
 *
 * This class is a wrapper around the mpq structure and functions
 * from the gmp.d interface. Arithmetic operations like add, mult,
 * etc allocate a new object and call the low-level gmp function.
 * The underlying mpq_t struct is public and can be directly passed
 * to the gmp.d interface.
 *
 */
class mpq {

  mpq_t mp;       ///< low-level mpq_t data structure
  int recycle;    ///< flag that value is temporary

  /** Construct mpq object and initialize to zero.*/
  this() {
    mpq_init(mp);
  }

  /** Construct mpq object and initialize.
   * \param y the value to initialize to
   */
  this(mpq y, int recycle = Recycle.Never) {
    mpq_init(mp);
    mpq_set(mp,y.mp);
    this.recycle = recycle;
  }

  /** Construct mpq object and initialize.
   * \param y the value to initialize to
   */
  this(double y, int recycle = Recycle.Never) {
    mpq_init(mp);
    mpq_set_d(mp,y);
    this.recycle = recycle;
  }

  /** Construct mpq object and initialize.
   * \param num the numerator
   * \param den the denominator
   */
  this(gmp_ulong num, gmp_ulong den, int recycle = Recycle.Never) {
    mpq_init(mp);
    mpq_set_ui(mp,num,den);
    this.recycle = recycle;
  }

  /** Construct mpq object and initialize.
   * \param num the numerator
   * \param den the denominator
   */
  this(int num, int den, int recycle = Recycle.Never) {
    mpq_init(mp);
    mpq_set_si(mp,cast(gmp_long)num,cast(gmp_long)den);
    this.recycle = recycle;
  }

  /** Construct mpq object and initialize.
   * \param num the numerator
   * \param den the denominator
   */
  this(mpz num, mpz den, int recycle = Recycle.Never) {
    mpq_init(mp);
    mpq_set_num(mp,num.mp);
    mpq_set_den(mp,den.mp);
    this.recycle = recycle;
  }

  /** Construct mpq object and initialize.
   * \param y the value to initialize to
   * \param base the base of the digits in y
   */
  this(char[] y,int base, int recycle = Recycle.Never) {
    mpq_init(mp);
    mpq_set_str(mp,toStringz(y),base);
    this.recycle = recycle;
  }

  /** Property to mark an mpq object as no longer temporary. It 
   * will not be recycled after being used in an arithmetic operation.
   * \return this
   */
  final mpq save() {
    recycle |= Recycle.Temp;
    return this;
  }
  
  private static this() {
    mpqpool = new TGmpPool!(mpq);
    mpqpool.clearAll();
  }
  
  /** Compute absolute value
   * \param x the value to take the absolute value of
   * \return the absolute value of x
   */
  final static mpq abs(mpq x) {
    mpq res = mpqpool.allocate();
    mpq_abs(res.mp,x.mp);
    debug (MPQ_DEBUG) {
      gmp_printf("abs(%Qd) got %Qd\n",&x.mp,&res.mp);
    }
    res.recycle = (x.recycle & Recycle.Never);
    if (x.recycle == Recycle.Self)
      mpqpool.recycle(x);
    return res;
  }

  /** Compute sum
   * \param y the value to add to
   * \return the sum of this and y.
   */
  final mpq opAdd(mpq y) {
    mpq res = mpqpool.allocate();
    mpq_add(res.mp,mp,y.mp); 
    debug (MPQ_DEBUG) {
      gmp_printf("%Qd + %Qd got %Qd\n",&mp,&y.mp,&res.mp);
    }
    res.recycle = (y.recycle & Recycle.Never) | (y.recycle & Recycle.Never);
    if (y.recycle == Recycle.Self)
      mpqpool.recycle(y);
    if (recycle == Recycle.Self)
      mpqpool.recycle(this);
    return res;
  }

  /** Add and assign (+=)
   * \param y the value to add to
   * \return resulting value
   */
  final mpq opAddAssign(mpq y) {
    mpq_add(mp,mp,y.mp);
    debug (MPQ_DEBUG) {
      gmp_printf(" += %Qd got %Qd\n",&y.mp,&mp);
    }
    if (y.recycle == Recycle.Self)
      mpqpool.recycle(y);
    return this;
  }

  /** Comparison
   * \param y the value to compare to
   * \return -1 if less, 0 is equal and 1 is more
   */
  final int opCmp(int y) {
    int res = mpq_cmp_si(mp,cast(gmp_long)y,cast(gmp_long)1);
    debug (MPQ_DEBUG) {
      gmp_printf("cmp(%Qd,%d) got %d\n",&mp,y,res);
    }
    if (recycle == Recycle.Self)
      mpqpool.recycle(this);
    return res;
  }

  /** Comparison
   * \param y the value to compare to
   * \return -1 if less, 0 is equal and 1 is more
   */
  final int opCmp(mpq y) {
    int res = mpq_cmp(mp,y.mp);
    debug (MPQ_DEBUG) {
      gmp_printf("cmp(%Qd,%Qd) got %d\n",&mp,&y.mp,res);
    }
    if (y.recycle == Recycle.Self)
      mpqpool.recycle(y);
    if (recycle == Recycle.Self)
      mpqpool.recycle(this);
    return res;
  }

  /** Canonicalize to lowest terms. Factor out any common terms 
   * from the numerator and denominator and return the result.
   * \return this
   */
  final mpq canonicalize() {
    mpq_canonicalize(mp);
    debug (MPQ_DEBUG) {
      gmp_printf("canonizalize got %Qd\n",&mp);
    }
    return this;
  }

  /** Divide
   * \param y the value to divide
   * \return the quotient of this and y, truncated
   */
  final mpq opDiv(mpq y) {
    mpq res = mpqpool.allocate();
    mpq_div(res.mp,mp,y.mp);
    debug (MPQ_DEBUG) {
      gmp_printf("%Qd / %Qd got %Qd\n",&mp,&y.mp,&res.mp);
    }
    res.recycle = (y.recycle & Recycle.Never) | (y.recycle & Recycle.Never);
    if (y.recycle == Recycle.Self)
      mpqpool.recycle(y);
    if (recycle == Recycle.Self)
      mpqpool.recycle(this);
    return res;
  }

   /** Divide and assign (/=)
    * \param y the value to divide
    * \return resulting value
    */
   final mpq opDivAssign(mpq y) {
      mpq_div(mp,mp,y.mp);
      debug (MPQ_DEBUG) {
	 gmp_printf(" /= %Qd got %Qd\n",&y.mp,&mp);
      }
      return this;
   }

  /** Equality
   * \param y the value to compare to
   * \return true if object equals y
   */
  final int opEquals(int y) {
    int res = (mpq_cmp_si(mp,cast(gmp_long)y,cast(gmp_long)1) == 0); 
    debug (MPQ_DEBUG) {
      gmp_printf("%Qd == %d got %d\n",&mp,y,res);
    }
    if (recycle == Recycle.Self)
      mpqpool.recycle(this);
    return res;
  }

  /** Equality
   * \param y the value to compare to
   * \return true if object equals y
   */
  final int opEquals(mpq y) {
    int res = (mpq_cmp(mp,y.mp) == 0); 
    debug (MPQ_DEBUG) {
      gmp_printf("%Qd == %Qd got %d\n",&mp,&y.mp,res);
    }
    if (recycle == Recycle.Self)
      mpqpool.recycle(this);
    if (y.recycle == Recycle.Self)
      mpqpool.recycle(y);
    return res;
  }

  /** Invert
   * \return the inverse of this
   */
  final mpq invert() {
    mpq res = mpqpool.allocate();
    mpq_inv(res.mp,mp);
    debug (MPQ_DEBUG) {
      gmp_printf("1/%Qd got %Qd\n",&mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpqpool.recycle(this);
    return res;
  }

  /** Get numerator
   * \return numerator integer
   */
  final mpz num() {
    mpz res = mpzpool.allocate();
    mpq_get_num(res.mp,mp);
    debug (MPQ_DEBUG) {
      gmp_printf("get_num(%Qd) got %Zd\n",&mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpqpool.recycle(this);
    return res;
  }

  /** Get denominator
   * \return denominator integer
   */
  final mpz den() {
    mpz res = mpzpool.allocate();
    mpq_get_den(res.mp,mp);
    debug (MPQ_DEBUG) {
      gmp_printf("get_den(%Qd) got %Zd\n",&mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpqpool.recycle(this);
    return res;
  }

  /** Convert to double
   * \return this as a double
   */
  final double get_d() {
    double res = mpq_get_d(mp);
    debug (MPQ_DEBUG) {
      gmp_printf("get_d(%Qd) got %g\n",&mp,res);
    }
    if (recycle == Recycle.Self)
      mpqpool.recycle(this);
    return res;
  }

  /** Convert to string
   * \return this as a string
   */
  final char[] toString() {
    char[] res = new char[mpz_sizeinbase(mp._mp_num,10)+
			  mpz_sizeinbase(mp._mp_den,10)+3];
    mpq_get_str(cast(char*)res,10,mp);
    int n = res.length;
    while (res[n-1] == 0)
      n--;
    res.length = n;
    debug (MPQ_DEBUG) {
      gmp_printf("toString(%Qd) got %.*s\n",&mp,res);
    }
    if (recycle == Recycle.Self)
      mpqpool.recycle(this);
    return res;
  }

  /** Multiply
   * \param y the value to multiply
   * \return the product of this and y.
   */
  final mpq opMul(mpq y) {
    mpq res = mpqpool.allocate();
    mpq_mul(res.mp,mp,y.mp);
    debug (MPQ_DEBUG) {
      gmp_printf("%Qd * %Qd got %Qd\n",&mp,&y.mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never) | (y.recycle & Recycle.Never);
    if (y.recycle == Recycle.Self)
      mpqpool.recycle(y);
    if (recycle == Recycle.Self)
      mpqpool.recycle(this);
    return res;
  }

  /** Multiply and assign (*=)
   * \param y the value to multiply
   * \return resulting value
   */
  final mpq opMulAssign(mpq y) {
    mpq_mul(mp,mp,y.mp);
    debug (MPQ_DEBUG) {
      gmp_printf(" *= %Qd got %Qd\n",&y.mp,&mp);
    }
    if (y.recycle == Recycle.Self)
      mpqpool.recycle(y);
    return this;
  }

  /** Negative
   * \return the negative of this
   */
  final mpq opNeg() {
    mpq res = mpqpool.allocate();
    mpq_neg(res.mp,mp);
    debug (MPQ_DEBUG) {
      gmp_printf("-%Qd got %Qd\n",&mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpqpool.recycle(this);
    return res;
  }

  /** Compute difference
   * \param y the value to subtract
   * \return the difference of this and y.
   */
  final mpq opSub(mpq y) {
    mpq res = mpqpool.allocate();
    mpq_sub(res.mp,mp,y.mp); 
    debug (MPQ_DEBUG) {
      gmp_printf("%Qd - %Qd got %Qd\n",&mp,&y.mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never) | (y.recycle & Recycle.Never);
    if (y.recycle == Recycle.Self)
      mpqpool.recycle(y);
    if (recycle == Recycle.Self)
      mpqpool.recycle(this);
    return res;
  }

  /** Subtract and assign (-=)
   * \param y the value to subtract
   * \return resulting value
   */
  final mpq opSubAssign(mpq y) {
    mpq_sub(mp,mp,y.mp);
    debug (MPQ_DEBUG) {
      gmp_printf(" -= %Qd got %Qd\n",&y.mp,&mp);
    }
    if (y.recycle == Recycle.Self)
      mpqpool.recycle(y);
    return this;
  }

  unittest {
    mpq x = new mpq(3);
    assert(x+(new mpq(4)) == 7);
    assert((new mpq(4))+x == 7);
    mpq x1 = new mpq(-7);
    assert(-x1 == 7);
    assert(x-new mpq(4) == -1);
    assert(new mpq(4)-x == 1);
    mpq y = new mpq(7U);
    mpq z = new mpq(10);
    assert(x+y == z);
    assert(y+x == 10);
    assert(x-y == -4);
    assert(y-x == -(x-y));
    assert(y-(new mpq(3))*x+x*y == 19); // 7-3*3+3*7 == 19
    assert(z/x == new mpq(10,3));

    assert(y < 10);
    assert(y < z);
    assert(10 >= y);
    assert(x+y <= z);

    assert(-x == -3);
    assert(mpq.abs(-x) == 3);

    mpq a = new mpq("1234567890123456789012345678901234567890",10);
    mpq b = new mpq("123456789012345678901234567890123456789",10);
    assert(b*(new mpq(10)) == a);

    b = new mpq(y);
    assert(b == y);

    b += new mpq(3);
    assert(b == 10);
    b += b;
    assert(b == 20);
    assert(strcmp(b.toString(),"20")==0);
    assert(b.get_d() == 20.0);

    mpq c = new mpq(b);
    c /= new mpq(2);
    assert(c == 10);
    c *= new mpq(c);
    assert(c == 100);
    c -= c/(new mpq(10));
    assert(c == 90);
  }
}

/** \var mpqpool 
 * The pool of mpq object instantiated from the template in gmppool.d
 */
static TGmpPool!(mpq) mpqpool;

/** Recycle any previous value in x, assign val and mark val
 * as not being a temporary object.
 * \param x the variable to assign to
 * \param val the value to assign to x
 */
void assign(inout mpq x, mpq val) {
  if (x !== null && x.recycle != Recycle.Never)
    mpqpool.recycle(x);
  val.recycle |= Recycle.Temp;
  x = val;
}

