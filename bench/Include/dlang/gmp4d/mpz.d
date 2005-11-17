/** \file mpz.d
 * \brief Object wrapper for mpz_t
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

private import std.string;

//debug = MPZ_DEBUG;

/** \class mpz
 * \brief Object wrapper for mpz_t
 *
 * This class is a wrapper around the mpz structure and functions
 * from the gmp.d interface. Arithmetic operations like add, mult,
 * etc allocate a new object and call the low-level gmp function.
 * Since allocating new objects can be expensive even with garbage
 * collection the <tt>mpzpool</tt> can be used to fine-tune
 * performace. The pool typically cuts the overhead of using the
 * object wrapper in tight loops from about 10-20% to about 1%. 
 * To obtain the best performance, however, pass the field containing 
 * the underlying mpz_t struct directly to the gmp.d interface.
 *
 * For example, if x is an mpz object then
 * \code
 *   assign(x,x+1);
 * \endcode
 * allocates a new mpz, computes the sum and assigns to x. Calling
 * \code
 *   mpz_add_ui(x.mp, x.mp, 1)
 * \endcode
 * directly manipulates x and does not return any value. Any result of
 * an arithmetic operation is assumed to be a temporary value that
 * will be recycled by the next arithmetic operation. To use a value
 * in multiple expressions or multiple times in an expression use the
 * <tt>save</tt> property or <tt>assign</tt> function. For example:
 * 
 * \code
 *   mpz x = new mpz("12345678901234567890",10);
 *   for (int k = 0; k < 10000; k++) {
 *      assign(x, x-2*(x + 1));
 *   }
 *   
 * \endcode
 */
class mpz {

  mpz_t mp;       ///< low-level mpz_t data structure
  int recycle = Recycle.Never; ///< flag that value is temporary

  /** Construct mpz object and initialize to zero.*/
  this() {mpz_init(mp);}

  /** Construct mpz object and initialize.
   * \param y the value to initialize to
   */
  this(mpz y, Recycle recycle = Recycle.Never) {
    mpz_init_set(mp,y.mp);
    this.recycle = recycle;
  }

  /** Construct mpz object and initialize.
   * \param y the value to initialize to
   */
  this(gmp_ulong y, Recycle recycle = Recycle.Never) {
    mpz_init_set_ui(mp,y);
    this.recycle = recycle;
  }

  /** Construct mpz object and initialize.
   * \param y the value to initialize to
   */
  this(int y, Recycle recycle = Recycle.Never) {
    mpz_init_set_si(mp,cast(gmp_long)y);
    this.recycle = recycle;
  }

  /** Construct mpz object and initialize.
   * \param y the value to initialize to
   * \param base the base of the digits in y
   */
  this(char[] y,int base, Recycle recycle = Recycle.Never) {
    mpz_init_set_str(mp,toStringz(y),base);
    this.recycle = recycle;
  }

  /** Property to mark an mpz object as no longer temporary. It 
   * will not be recycled after being used in an arithmetic operation.
   * \return this
   */
  final mpz save() {
    recycle |= Recycle.Temp;
    return this;
  }
  
  private static this() {
    mpzpool = new TGmpPool!(mpz);
    mpzpool.clearAll();
  }
  
  /** Compute absolute value
   * \param x the value to take the absolute value of
   * \return the absolute value of x
   */
  final static mpz abs(mpz x) {
    mpz res = mpzpool.allocate();
    mpz_abs(res.mp,x.mp);
    debug (MPZ_DEBUG) {
      gmp_printf("abs(%Zd) got %Zd\n",&x.mp,&res.mp);
    }
    res.recycle = (x.recycle & Recycle.Never);
    if (x.recycle == Recycle.Self)
      mpzpool.recycle(x);
    return res;
  }

  /** Compute sum
   * \param y the value to add to
   * \return the sum of this and y.
   */
  final mpz opAdd(int y) {
    mpz res = mpzpool.allocate();
    if (y >= 0)
      mpz_add_ui(res.mp,mp,cast(gmp_ulong)y); 
    else
      mpz_sub_ui(res.mp,mp,cast(gmp_ulong)(-y));
    debug (MPZ_DEBUG) {
      gmp_printf("%Zd + %d got %Zd\n",&mp,y,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Compute sum
   * \param y the value to add to
   * \return the sum of this and y.
   */
  final mpz opAdd(mpz y) {
    mpz res = mpzpool.allocate();
    mpz_add(res.mp,mp,y.mp); 
    debug (MPZ_DEBUG) {
      gmp_printf("%Zd + %Zd got %Zd\n",&mp,&y.mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never) | (y.recycle & Recycle.Never);
    if (y.recycle == Recycle.Self)
      mpzpool.recycle(y);
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Add and assign (+=)
   * \param y the value to add to
   * \return resulting value
   */
  final mpz opAddAssign(int y) {
    if (y >= 0)
      mpz_add_ui(mp,mp,cast(gmp_ulong)y);
    else
      mpz_sub_ui(mp,mp,cast(gmp_ulong)(-y));
    debug (MPZ_DEBUG) {
      gmp_printf(" += %d got %Zd\n",y,&mp);
    }
    return this;
  }

  /** Add and assign (+=)
   * \param y the value to add to
   * \return resulting value
   */
  final mpz opAddAssign(mpz y) {
    mpz_add(mp,mp,y.mp);
    debug (MPZ_DEBUG) {
      gmp_printf(" += %Zd got %Zd\n",&y.mp,&mp);
    }
    if (y.recycle == Recycle.Self)
      mpzpool.recycle(y);
    return this;
  }

  /** Binomial coefficient
   * \param n the n in "n choose k"
   * \param k the k in "n choose k"
   * \return binomial coeff of n choose k
   */
  final static mpz bin(mpz n,int k) {
    mpz res = mpzpool.allocate();
    mpz_bin_ui(res.mp,n.mp,cast(gmp_ulong)k); 
    debug (MPZ_DEBUG) {
      gmp_printf("bin(%Zd,%d) got %Zd\n",&n.mp,k,&res.mp);
    }
    res.recycle = (n.recycle & Recycle.Never);
    if (n.recycle == Recycle.Self)
      mpzpool.recycle(n);
    return res;
  }

  /** Comparison
   * \param y the value to compare to
   * \return -1 if less, 0 is equal and 1 is more
   */
  final int opCmp(int y) {
    int res = mpz_cmp_si(mp,cast(gmp_long)y);
    debug (MPZ_DEBUG) {
      gmp_printf("cmp(%Zd,%d) got %d\n",&mp,y,res);
    }
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Comparison
   * \param y the value to compare to
   * \return -1 if less, 0 is equal and 1 is more
   */
  final int opCmp(mpz y) {
    int res = mpz_cmp(mp,y.mp);
    debug (MPZ_DEBUG) {
      gmp_printf("cmp(%Zd,%Zd) got %d\n",&mp,&y.mp,res);
    }
    if (y.recycle == Recycle.Self)
      mpzpool.recycle(y);
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Divide
   * \param y the value to divide
   * \return the quotient of this and y, truncated
   */
  final mpz opDiv(int y) {
    mpz res = mpzpool.allocate();
    mpz_tdiv_q_ui(res.mp,mp,cast(gmp_long)y); 
    debug (MPZ_DEBUG) {
      gmp_printf("%Zd / %d got %Zd\n",&mp,y,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Divide
   * \param y the value to divide
   * \return the quotient of this and y, truncated
   */
  final mpz opDiv(mpz y) {
    mpz res = mpzpool.allocate();
    mpz_tdiv_q(res.mp,mp,y.mp);
    debug (MPZ_DEBUG) {
      gmp_printf("%Zd / %Zd got %Zd\n",&mp,&y.mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never) | (y.recycle & Recycle.Never);
    if (y.recycle == Recycle.Self)
      mpzpool.recycle(y);
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

   /** Divide
    * \param y the value to divide
    * \return the quotient of this and y, truncated
    */
   final gmp_long opDiv_r(int y) {
      gmp_long res = cast(gmp_long)y/si();
      debug (MPZ_DEBUG) {
	 gmp_printf("%d / %Zd got %d\n",y,&mp,res);
      }
      return res;
   }

   /** Divide and assign (/=)
    * \param y the value to divide
    * \return resulting value
    */
   final mpz opDivAssign(int y) {
      if (y >= 0)
	 mpz_tdiv_q_ui(mp,mp,cast(gmp_ulong)y);
      else {
	 mpz_tdiv_q_ui(mp,mp,cast(gmp_ulong)(-y));
	 mpz_neg(mp,mp);
      }
      debug (MPZ_DEBUG) {
	 gmp_printf(" /= %d got %Zd\n",y,&mp);
      }
      return this;
   }

   /** Divide and assign (/=)
    * \param y the value to divide
    * \return resulting value
    */
   final mpz opDivAssign(mpz y) {
      mpz_tdiv_q(mp,mp,y.mp);
      debug (MPZ_DEBUG) {
	 gmp_printf(" /= %Zd got %Zd\n",&y.mp,&mp);
      }
      return this;
   }

  /** Equality
   * \param y the value to compare to
   * \return true if object equals y
   */
  final int opEquals(int y) {
    int res = (mpz_cmp_si(mp,cast(gmp_long)y) == 0); 
    debug (MPZ_DEBUG) {
      gmp_printf("%Zd == %d got %d\n",&mp,y,res);
    }
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Equality
   * \param y the value to compare to
   * \return true if object equals y
   */
  final int opEquals(mpz y) {
    int res = (mpz_cmp(mp,y.mp) == 0); 
    debug (MPZ_DEBUG) {
      gmp_printf("%Zd == %Zd got %d\n",&mp,&y.mp,res);
    }
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    if (y.recycle == Recycle.Self)
      mpzpool.recycle(y);
    return res;
  }

  /** Convert to gmp_ulong
   * \return this as a gmp_ulong
   */
  final gmp_ulong ui() {
    gmp_ulong res = mpz_get_ui(mp);
    debug (MPZ_DEBUG) {
      gmp_printf("ui(%Zd) got %u\n",&mp,res);
    }
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Set new unsigned value
   * \param x the new value
   */
  final void ui(gmp_ulong x) {
    mpz_set_ui(mp,x);
  }

  /** Convert to gmp_long
   * \return this as a gmp_long
   */
  final gmp_long si() {
    gmp_long res = mpz_get_si(mp);
    debug (MPZ_DEBUG) {
      gmp_printf("get_si(%Zd) got %d\n",&mp,res);
    }
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Set new signed value
   * \param x the new value
   */
  final void si(gmp_long x) {
    mpz_set_si(mp,x);
  }

  /** Convert to double
   * \return this as a double
   */
  final double get_d() {
    double res = mpz_get_d(mp);
    debug (MPZ_DEBUG) {
      gmp_printf("get_d(%Zd) got %g\n",&mp,res);
    }
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Convert to string
   * \return this as a string
   */
  final char[] toString() {
    char[] res = new char[mpz_sizeinbase(mp,10)+2];
    mpz_get_str(cast(char*)res,10,mp);
    int n = res.length;
    while (res[n-1] == 0)
      n--;
    res.length = n;
    debug (MPZ_DEBUG) {
      gmp_printf("toString(%Zd) got %.*s\n",&mp,res);
    }
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Compute mod
   * \param y the base for 
   * \return the remainder of this/y.
   */
  final gmp_ulong opMod(int y) {
    gmp_ulong res = mpz_fdiv_ui(mp,cast(gmp_long)y); 
    debug (MPZ_DEBUG) {
      gmp_printf("%Zd %% %d got %d\n",&mp,y,res);
    }
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Compute mod
   * \param y the base for 
   * \return the remainder of this/y.
   */
  final mpz opMod(mpz y) {
    mpz res = mpzpool.allocate();
    mpz_mod(res.mp,mp,y.mp);
    debug (MPZ_DEBUG) {
      gmp_printf("%Zd %% %Zd got %Zd\n",&mp,&y.mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never) | (y.recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    if (y.recycle == Recycle.Self)
      mpzpool.recycle(y);
    return res;
  }

  /** Compute mod and assign (%=)
   * \param y the base for 
   * \return the remainder of this/y.
   */
  final mpz opModAssign(int y) {
    gmp_ulong res = mpz_fdiv_ui(mp,cast(gmp_long)y); 
    mpz_set_ui(mp,res);
    debug (MPZ_DEBUG) {
      gmp_printf(" %%= %d got %Zd\n",y,&mp);
    }
    return this;
  }

  /** Compute mod and assign (%=)
   * \param y the base for 
   * \return the remainder of this/y.
   */
  final mpz opModAssign(mpz y) {
    mpz_mod(mp,mp,y.mp);
    debug (MPZ_DEBUG) {
      gmp_printf(" %%= %Zd got %Zd\n",&y.mp,&mp);
    }
    if (y.recycle == Recycle.Self)
      mpzpool.recycle(y);
    return this;
  }

  /** Compute mod
   * \param y the base for 
   * \return the remainder of y/this.
   */
  final gmp_long opMod_r(int y) {
    gmp_long res = cast(gmp_long)y % si();
    debug (MPZ_DEBUG) {
      gmp_printf("%d %% %Zd got %d\n",y,&mp,res);
    }
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Multiply
   * \param y the value to multiply
   * \return the product of this and y.
   */
  final mpz opMul(int y) {
    mpz res = mpzpool.allocate();
    mpz_mul_si(res.mp,mp,cast(gmp_long)y); 
    debug (MPZ_DEBUG) {
      gmp_printf("%Zd * %d got %Zd\n",&mp,y,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Multiply
   * \param y the value to multiply
   * \return the product of this and y.
   */
  final mpz opMul(mpz y) {
    mpz res = mpzpool.allocate();
    mpz_mul(res.mp,mp,y.mp);
    debug (MPZ_DEBUG) {
      gmp_printf("%Zd * %Zd got %Zd\n",&mp,&y.mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never) | (y.recycle & Recycle.Never);
    if (y.recycle == Recycle.Self)
      mpzpool.recycle(y);
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Multiply and assign (*=)
   * \param y the value to multiply
   * \return resulting value
   */
  final mpz opMulAssign(int y) {
    mpz_mul_si(mp,mp,cast(gmp_long)y);
    debug (MPZ_DEBUG) {
      gmp_printf(" *= %d got %Zd\n",y,&mp);
    }
    return this;
  }

  /** Multiply and assign (*=)
   * \param y the value to multiply
   * \return resulting value
   */
  final mpz opMulAssign(mpz y) {
    mpz_mul(mp,mp,y.mp);
    debug (MPZ_DEBUG) {
      gmp_printf(" *= %Zd got %Zd\n",&y.mp,&mp);
    }
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return this;
  }

  /** Negative
   * \return the negative of this
   */
  final mpz opNeg() {
    mpz res = mpzpool.allocate();
    mpz_neg(res.mp,mp);
    debug (MPZ_DEBUG) {
      gmp_printf("-%Zd got %Zd\n",&mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Post decrement
   * \return original value before decrementing
   */
  final mpz opPostDec() {
    mpz res = mpzpool.allocate();
    mpz_set(res.mp,mp);
    mpz_sub_ui(mp,mp,1);
    debug (MPZ_DEBUG) {
      gmp_printf("postdec got %Zd, returning %Zd\n",&mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never);
    return res;
  }

  /** Post increment
   * \return original value before incrementing
   */
  final mpz opPostInc() {
    mpz res = mpzpool.allocate();
    mpz_set(res.mp,mp);
    mpz_add_ui(mp,mp,1);
    debug (MPZ_DEBUG) {
      gmp_printf("postinc got %Zd, returning %Zd\n",&mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never);
    return res;
  }

  /** Compute base^nth power
   * \param x the base
   * \param n compute the nth power
   * \return this to the nth power
   */
  final static mpz pow(mpz x,int n) {
    mpz res = mpzpool.allocate();
    mpz_pow_ui(res.mp,x.mp,cast(gmp_ulong)n); 
    debug (MPZ_DEBUG) {
      gmp_printf("root(%Zd,%d) got %Zd\n",&x.mp,n,&res.mp);
    }
    res.recycle = (x.recycle & Recycle.Never);
    if (x.recycle == Recycle.Self)
      mpzpool.recycle(x);
    return res;
  }

  /** Compute nth root.
   * \param x the value to take the root of
   * \param n compute the nth root
   * \return the nth root of this rounded down
   */
  final static mpz root(mpz x,int n) {
    mpz res = mpzpool.allocate();
    mpz_root(res.mp,x.mp,cast(gmp_ulong)n); 
    debug (MPZ_DEBUG) {
      gmp_printf("root(%Zd,%d) got %Zd\n",&x.mp,n,&res.mp);
    }
    res.recycle = (x.recycle & Recycle.Never);
    if (x.recycle == Recycle.Self)
      mpzpool.recycle(x);
    return res;
  }

  /** Shift left operator
   * \param y the value to shift by
   * \return the product of this and 2^y.
   */
  final mpz opShl(int y) {
    mpz res = mpzpool.allocate();
    mpz_mul_2exp(res.mp,mp,cast(gmp_ulong)y); 
    debug (MPZ_DEBUG) {
      gmp_printf("%Zd << %d got %Zd\n",&mp,y,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Shift right operator
   * \param y the value to shift by
   * \return the quotient of this and 2^y.
   */
  final mpz opShr(int y) {
    mpz res = mpzpool.allocate();
    mpz_fdiv_q_2exp(res.mp,mp,cast(gmp_ulong)y); 
    debug (MPZ_DEBUG) {
      gmp_printf("%Zd >> %d got %Zd\n",&mp,y,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Sqrt
   * \param x the number to take the square root of
   * \return the square root of x rounded down
   */
  final static mpz sqrt(mpz x) {
    mpz res = mpzpool.allocate();
    mpz_sqrt(res.mp,x.mp); 
    debug (MPZ_DEBUG) {
      gmp_printf("sqrt(%Zd) got %Zd\n",&x.mp,&res.mp);
    }
    res.recycle = (x.recycle & Recycle.Never);
    if (x.recycle == Recycle.Self)
      mpzpool.recycle(x);
    return res;
  }

  /** Compute difference
   * \param y the value to subtract
   * \return the difference of this and y.
   */
  final mpz opSub(int y) {
    mpz res = mpzpool.allocate();
    if (y >= 0)
      mpz_sub_ui(res.mp,mp,cast(gmp_ulong)y); 
    else
      mpz_sub_ui(res.mp,mp,cast(gmp_ulong)(-y));
    debug (MPZ_DEBUG) {
      gmp_printf("%Zd - %d got %Zd\n",&mp,y,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Compute difference
   * \param y the value to subtract
   * \return the difference of this and y.
   */
  final mpz opSub(mpz y) {
    mpz res = mpzpool.allocate();
    mpz_sub(res.mp,mp,y.mp); 
    debug (MPZ_DEBUG) {
      gmp_printf("%Zd - %Zd got %Zd\n",&mp,&y.mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never) | (y.recycle & Recycle.Never);
    if (y.recycle == Recycle.Self)
      mpzpool.recycle(y);
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Compute difference
   * \param y the value to subtract from
   * \return the difference of y and this.
   */
  final mpz opSub_r(int y) {
    mpz res = mpzpool.allocate();
    if (y >= 0)
      mpz_ui_sub(res.mp,cast(gmp_ulong)y,mp); 
    else {
      mpz_add_ui(res.mp,mp,cast(gmp_ulong)(-y));
      mpz_neg(res.mp,res.mp);
    }
    debug (MPZ_DEBUG) {
      gmp_printf("%d - %Zd got %Zd\n",y,&mp,&res.mp);
    }
    res.recycle = (recycle & Recycle.Never);
    if (recycle == Recycle.Self)
      mpzpool.recycle(this);
    return res;
  }

  /** Subtract and assign (-=)
   * \param y the value to subtract
   * \return resulting value
   */
  final mpz opSubAssign(int y) {
    if (y >= 0)
      mpz_sub_ui(mp,mp,cast(gmp_ulong)y);
    else
      mpz_add_ui(mp,mp,cast(gmp_ulong)(-y));
    debug (MPZ_DEBUG) {
      gmp_printf(" -= %d got %Zd\n",y,&mp);
    }
    return this;
  }

  /** Subtract and assign (-=)
   * \param y the value to subtract
   * \return resulting value
   */
  final mpz opSubAssign(mpz y) {
    mpz_sub(mp,mp,y.mp);
    debug (MPZ_DEBUG) {
      gmp_printf(" -= %Zd got %Zd\n",&y.mp,&mp);
    }
    if (y.recycle == Recycle.Self)
      mpzpool.recycle(y);
    return this;
  }

  /** Generate random number
   */
  mpz urandomb(gmp_randstate_t seed, ulong n) {
    mpz_urandomb(mp,seed,n);
    return this;
  }

  unittest {
    mpz x = new mpz(3);
    assert(x+4 == 7);
    assert(4+x == 7);
    mpz x1 = new mpz(-7);
    assert(-x1 == 7);
    assert(x-4 == -1);
    assert(4-x == 1);
    mpz y = new mpz(7U);
    mpz z = new mpz(10);
    assert(x+y == z);
    assert(y+x == 10);
    assert(x-y == -4);
    assert(y-x == -(x-y));
    assert(y-3*x+x*y == 19); // 7-3*3+3*7 == 19
    assert(z/x == 3);
    assert(10/x == 3);
    assert(z/3 == 3);

    assert(y < 10);
    assert(y < z);
    assert(10 >= y);
    assert(x+y <= z);

    assert(-x == -3);
    assert(mpz.abs(-x) == 3);

    mpz a = new mpz("1234567890123456789012345678901234567890",10);
    mpz b = new mpz("123456789012345678901234567890123456789",10);
    assert(b*10 == a);

    assert(y++ == 7);
    assert(y-- == 8);
    assert(y == 7);

    b = new mpz(y);
    assert(b == y);

    b += 3;
    assert(b == 10);
    b += b;
    assert(b == 20);
    assert(strcmp(b.toString,"20")==0);
    assert(b.si == 20);
    assert(b.ui == 20);
    assert(b.get_d == 20.0);

    mpz c = new mpz(b);
    c /= 2;
    assert(c == 10);
    c *= c;
    assert(c == 100);
    c -= c/10;
    assert(c == 90);
    c %= 16;
    assert(c == 10);

    assert(b << 2 == 80);
    assert(b >> 2 == 5);

    assert(mpz.pow(x,3) == 27);
    assert(mpz.root(mpz.pow(x,3),3) == x);
    assert(mpz.sqrt(b*b) == b);

    assert(b % 3 == 2);
    assert(44 % b == 4);
    assert((125*b + 13) % b == 13);

  }
}

/** \var mpzpool 
 * The pool of mpz object instantiated from the template in gmppool.d
 */
static TGmpPool!(mpz) mpzpool;

/** Recycle any previous value in x, assign val and mark val
 * as not being a temporary object.
 * \param x the variable to assign to
 * \param val the value to assign to x
 */
void assign(inout mpz x, mpz val) {
  //if (x !== null && x.recycle != Recycle.Never)
  if (x !is null && x.recycle != Recycle.Never)
    mpzpool.recycle(x);
  val.recycle |= Recycle.Temp;
  x = val;
}

