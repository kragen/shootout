/** \mainpage  GNU Multi-precision library interface for D
 * There are two parts to this interface to the C library GMP.
 * The first, in the file gmp.d, is the low-level interface directly 
 * to the C API.<br>
 * The second, in the files mpz.d, mpq.d and mpf.d, are D classes providing
 * a high-level interface that can be tuned for high performance when
 * needed.<br>
 * For more information about GMP or D see http://www.swox.com/gmp and
 * http://www.digitalmars.com/d
 */

/** \file gmp.d 
 * \brief Low-level GNU Multi-precision library interface for D
 *
 * gmp.d is a translation of the primary functions in gmp.h.
 * The mpn, mp and mpfr functions are not included in this file. 
 * Also, none of the inline declarations from gmp.h are included. 
 *
 * For human-readable documentation see
 *  http://www.swox.com/gmp/manual/
 * That documentation is written for C but the only differences gmp.d
 * has from the C calling api are that <tt>long</tt> types should
 * be declared as <tt>gmp_long</tt> and that calls to gmp_printf 
 * (and other functions that take a variable number of inputs) 
 * need to be passed the address of all mpz_t, mpq_t and
 * mpf_t values. For example,
 *
 * \code
 *   mpz_t x;
 *   ...
 *   gmp_printf("%Zd\n", &x);
 * \endcode
 *
 * If gmp is built as a shared object you have to link by hand:
 *
 * \code
 *   dmd -c my_program.d gmp.d
 *   gcc my_program.o gmp.o -o my_program -lphobos -lpthread -lm -lgmp
 * \endcode
 * 
 * or, on MSWindows,
 *
 * \code
 *   dmd -c my_program.d gmp.d
 *   dmd my_program.o gmp.o -o my_program gmp.lib
 * \endcode
 *
 */

/* Translated from gmp.h for gmp-4.1.2
 * Copyright Ben Hinkle 2003-2005 ben.hinkle@gmail.com
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

import std.c.stdio;
import std.c.stdarg;

version = _GMP_H_HAVE_FILE;
version = _GMP_H_HAVE_VA_LIST;

// these aliases depends on the way the gmp library was compiled
// long can be 32 bits or 64 bits. D uses 64 bits.
alias int gmp_long;   
alias uint gmp_ulong;

alias gmp_ulong	mp_limb_t;
alias gmp_long	mp_limb_signed_t;
alias mp_limb_t *	mp_ptr;
alias mp_limb_t *	mp_srcptr;
alias gmp_long		mp_size_t;
alias gmp_long		mp_exp_t;

struct __mpz_struct
{
  int _mp_alloc;		/* Number of *limbs* allocated and pointed
				   to by the _mp_d field.  */
  int _mp_size;			/* abs(_mp_size) is the number of limbs the
				   last field points to.  If _mp_size is
				   negative this is a negative number.  */
  mp_limb_t *_mp_d;		/* Pointer to the limbs.  */
};

alias __mpz_struct mpz_t;

struct __mpq_struct
{
  __mpz_struct _mp_num;
  __mpz_struct _mp_den;
};

alias __mpq_struct MP_RAT;
alias __mpq_struct mpq_t;

struct __mpf_struct
{
  int _mp_prec;			/* Max precision, in number of `mp_limb_t's.
				   Set by mpf_init and modified by
				   mpf_set_prec.  The area pointed to by the
				   _mp_d field contains `prec' + 1 limbs.  */
  int _mp_size;			/* abs(_mp_size) is the number of limbs the
				   last field points to.  If _mp_size is
				   negative this is a negative number.  */
  mp_exp_t _mp_exp;		/* Exponent, in the base of `mp_limb_t'.  */
  mp_limb_t *_mp_d;		/* Pointer to the limbs.  */
};

/* typedef __mpf_struct MP_FLOAT; */
alias __mpf_struct mpf_t;

/* Available random number generation algorithms.  */
enum gmp_randalg_t
{
  GMP_RAND_ALG_DEFAULT = 0,
  GMP_RAND_ALG_LC = GMP_RAND_ALG_DEFAULT /* Linear congruential.  */
};

/* Linear congruential data struct.  */
struct __gmp_randata_lc {
  mpz_t _mp_a;			/* Multiplier. */
  gmp_ulong _mp_c;	/* Adder. */
  mpz_t _mp_m;			/* Modulus (valid only if m2exp == 0).  */
  gmp_ulong _mp_m2exp;	/* If != 0, modulus is 2 ^ m2exp.  */
};

/* Random state struct.  */
struct __gmp_randstate_struct
{
  mpz_t _mp_seed;		/* Current seed.  */
  gmp_randalg_t _mp_alg;	/* Algorithm used.  */
  union u {			/* Algorithm specific data.  */
    __gmp_randata_lc *_mp_lc;	/* Linear congruential.  */
  } 
  u _mp_algdata;
};
alias __gmp_randstate_struct gmp_randstate_t;

//alias uint size_t;
extern (C) {
    alias void * function (uint) __gmp_allocate_func;
    alias void * function (void *, size_t, size_t) __gmp_reallocate_func;
    alias void   function (void *, size_t) __gmp_free_func;

    void __gmp_set_memory_functions (__gmp_allocate_func,
                                     __gmp_reallocate_func,
                                     __gmp_free_func);
    alias __gmp_set_memory_functions mp_set_memory_functions;
}                                         

extern (C) int __gmp_bits_per_limb;
alias __gmp_bits_per_limb mp_bits_per_limb;

extern (C) int __gmp_errno;
alias __gmp_errno gmp_errno;

extern (C) char * __gmp_version;
alias __gmp_version gmp_version;

/**************** Random number routines.  ****************/

/* obsolete */
extern (C) deprecated void __gmp_randinit (inout gmp_randstate_t, gmp_randalg_t, ...);
alias __gmp_randinit gmp_randinit;

extern (C) void __gmp_randinit_default (inout gmp_randstate_t);
alias __gmp_randinit_default gmp_randinit_default;

extern (C) void __gmp_randinit_lc (inout gmp_randstate_t,
                              inout mpz_t, gmp_ulong, inout mpz_t);
alias __gmp_randinit_lc gmp_randinit_lc;

extern (C) void __gmp_randinit_lc_2exp (inout gmp_randstate_t,
                                   inout mpz_t, gmp_ulong,
				   gmp_ulong);
alias __gmp_randinit_lc_2exp gmp_randinit_lc_2exp;

extern (C) int __gmp_randinit_lc_2exp_size (inout gmp_randstate_t, gmp_ulong);
alias __gmp_randinit_lc_2exp_size gmp_randinit_lc_2exp_size;

extern (C) void __gmp_randseed (inout gmp_randstate_t, inout mpz_t);
alias __gmp_randseed gmp_randseed;

extern (C) void __gmp_randseed_ui (inout gmp_randstate_t, gmp_ulong);
alias __gmp_randseed_ui gmp_randseed_ui;

extern (C) void __gmp_randclear (inout gmp_randstate_t);
alias __gmp_randclear gmp_randclear;


/**************** Formatted output routines.  ****************/

extern (C) int gmp_asprintf (char **, char *, ...);
alias gmp_asprintf __gmp_asprintf;

version (_GMP_H_HAVE_FILE) {
    extern (C) int gmp_fprintf (FILE *, char *, ...);
    alias gmp_fprintf __gmp_fprintf;
}

version (_GMP_H_HAVE_OBSTACK) {
    extern (C) int __gmp_obstack_printf (obstack *,char *, ...);
    alias __gmp_obstack_printf gmp_obstack_printf;
}

version (_GMP_H_HAVE_OBSTACK) {
    extern (C) int __gmp_obstack_vprintf (obstack *, char *, va_list);
    alias __gmp_obstack_vprintf gmp_obstack_vprintf;
}

extern (C) int __gmp_printf (char *, ...);
alias __gmp_printf gmp_printf;

extern (C) int __gmp_snprintf (char *, size_t, char *, ...);
alias __gmp_snprintf gmp_snprintf;

extern (C) int __gmp_sprintf (char *, char *, ...);
alias __gmp_sprintf gmp_sprintf;

version (_GMP_H_HAVE_VA_LIST) {
    extern (C) int __gmp_vasprintf (char **, char *, va_list);
    alias __gmp_vasprintf gmp_vasprintf;
}

version (_GMP_H_HAVE_FILE) {
    extern (C) int __gmp_vfprintf (FILE *, char *, va_list);
    alias __gmp_vfprintf gmp_vfprintf;
}

version (_GMP_H_HAVE_VA_LIST) {
    extern (C) int __gmp_vprintf (char *, va_list);
    alias __gmp_vprintf gmp_vprintf;
}

version (_GMP_H_HAVE_VA_LIST) {
    extern (C) int __gmp_vsnprintf (char *, size_t, char *, va_list);
    alias __gmp_vsnprintf gmp_vsnprintf;
}

version (_GMP_H_HAVE_VA_LIST) {
    extern (C) int __gmp_vsprintf (char *, char *, va_list);
    alias __gmp_vsprintf gmp_vsprintf;
}


/**************** Formatted input routines.  ****************/

version (_GMP_H_HAVE_FILE) {
extern (C) int __gmp_fscanf (FILE *, char *, ...);
alias __gmp_fscanf gmp_fscanf;
}

extern (C) int __gmp_scanf (char *, ...);
alias __gmp_scanf gmp_scanf;

extern (C) int __gmp_sscanf (char *, char *, ...);
alias __gmp_sscanf gmp_sscanf;

version (_GMP_H_HAVE_FILE) {
extern (C) int __gmp_vfscanf (FILE *, char *, va_list);
alias __gmp_vfscanf gmp_vfscanf;
}

version (_GMP_H_HAVE_VA_LIST) {
extern (C) int __gmp_vscanf (char *, va_list);
alias __gmp_vscanf gmp_vscanf;
}

version (_GMP_H_HAVE_VA_LIST) {
extern (C) int __gmp_vsscanf (char *, char *, va_list);
alias __gmp_vsscanf gmp_vsscanf;
}


/**************** Integer (i.e. Z) routines.  ****************/

extern (C) void *__gmpz_realloc (inout mpz_t, mp_size_t);
alias __gmpz_realloc _mpz_realloc;
alias __gmpz_realloc mpz_realloc;

extern (C) void __gmpz_abs (inout mpz_t, inout mpz_t);
alias __gmpz_abs mpz_abs;

extern (C) void __gmpz_add (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_add mpz_add;

extern (C) void __gmpz_add_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_add_ui mpz_add_ui;

extern (C) void __gmpz_addmul (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_addmul mpz_addmul;

extern (C) void __gmpz_addmul_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_addmul_ui mpz_addmul_ui;

extern (C) void __gmpz_and (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_and mpz_and;

extern (C) void __gmpz_array_init (inout mpz_t, mp_size_t, mp_size_t);
alias __gmpz_array_init mpz_array_init;

extern (C) void __gmpz_bin_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_bin_ui mpz_bin_ui;

extern (C) void __gmpz_bin_uiui (inout mpz_t, gmp_ulong, gmp_ulong);
alias __gmpz_bin_uiui mpz_bin_uiui;

extern (C) void __gmpz_cdiv_q (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_cdiv_q mpz_cdiv_q;

extern (C) void __gmpz_cdiv_q_2exp (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_cdiv_q_2exp mpz_cdiv_q_2exp;

extern (C) gmp_ulong __gmpz_cdiv_q_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_cdiv_q_ui mpz_cdiv_q_ui;

extern (C) void __gmpz_cdiv_qr (inout mpz_t, inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_cdiv_qr mpz_cdiv_qr;

extern (C) gmp_ulong __gmpz_cdiv_qr_ui (inout mpz_t, inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_cdiv_qr_ui mpz_cdiv_qr_ui;

extern (C) void __gmpz_cdiv_r (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_cdiv_r mpz_cdiv_r;

extern (C) void __gmpz_cdiv_r_2exp (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_cdiv_r_2exp mpz_cdiv_r_2exp;

extern (C) gmp_ulong __gmpz_cdiv_r_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_cdiv_r_ui mpz_cdiv_r_ui;

extern (C) gmp_ulong __gmpz_cdiv_ui (inout mpz_t, gmp_ulong);
alias __gmpz_cdiv_ui mpz_cdiv_ui;

extern (C) void __gmpz_clear (inout mpz_t);
alias __gmpz_clear mpz_clear;

extern (C) void __gmpz_clrbit (inout mpz_t, gmp_ulong);
alias __gmpz_clrbit mpz_clrbit;

extern (C) int __gmpz_cmp (inout mpz_t, inout mpz_t);
alias __gmpz_cmp mpz_cmp;

extern (C) int __gmpz_cmp_d (inout mpz_t, double);
alias __gmpz_cmp_d mpz_cmp_d;

extern (C) int __gmpz_cmp_si (inout mpz_t, gmp_long);
alias __gmpz_cmp_si mpz_cmp_si;

extern (C) int __gmpz_cmp_ui (inout mpz_t, gmp_ulong);
alias __gmpz_cmp_ui mpz_cmp_ui;

extern (C) int __gmpz_cmpabs (inout mpz_t, inout mpz_t);
alias __gmpz_cmpabs mpz_cmpabs;

extern (C) int __gmpz_cmpabs_d (inout mpz_t, double);
alias __gmpz_cmpabs_d mpz_cmpabs_d;

extern (C) int __gmpz_cmpabs_ui (inout mpz_t, gmp_ulong);
alias __gmpz_cmpabs_ui mpz_cmpabs_ui;

extern (C) void __gmpz_com (inout mpz_t, inout mpz_t);
alias __gmpz_com mpz_com;

extern (C) int __gmpz_congruent_p (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_congruent_p mpz_congruent_p;

extern (C) int __gmpz_congruent_2exp_p (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_congruent_2exp_p mpz_congruent_2exp_p;

extern (C) int __gmpz_congruent_ui_p (inout mpz_t, gmp_ulong, gmp_ulong);
alias __gmpz_congruent_ui_p mpz_congruent_ui_p;

extern (C) void __gmpz_divexact (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_divexact mpz_divexact;

extern (C) void __gmpz_divexact_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_divexact_ui mpz_divexact_ui;

extern (C) int __gmpz_divisible_p (inout mpz_t, inout mpz_t);
alias __gmpz_divisible_p mpz_divisible_p;

extern (C) int __gmpz_divisible_ui_p (inout mpz_t, gmp_ulong);
alias __gmpz_divisible_ui_p mpz_divisible_ui_p;

extern (C) int __gmpz_divisible_2exp_p (inout mpz_t, gmp_ulong);
alias __gmpz_divisible_2exp_p mpz_divisible_2exp_p;

extern (C) void __gmpz_dump (inout mpz_t);
alias __gmpz_dump mpz_dump;

extern (C) void *__gmpz_export (void *, size_t *, int, size_t, int, size_t, inout mpz_t);
alias __gmpz_export mpz_export;

extern (C) void __gmpz_fac_ui (inout mpz_t, gmp_ulong);
alias __gmpz_fac_ui mpz_fac_ui;

extern (C) void __gmpz_fdiv_q (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_fdiv_q mpz_fdiv_q;

extern (C) void __gmpz_fdiv_q_2exp (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_fdiv_q_2exp mpz_fdiv_q_2exp;

extern (C) gmp_ulong __gmpz_fdiv_q_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_fdiv_q_ui mpz_fdiv_q_ui;

extern (C) void __gmpz_fdiv_qr (inout mpz_t, inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_fdiv_qr mpz_fdiv_qr;

extern (C) gmp_ulong __gmpz_fdiv_qr_ui (inout mpz_t, inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_fdiv_qr_ui mpz_fdiv_qr_ui;

extern (C) void __gmpz_fdiv_r (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_fdiv_r mpz_fdiv_r;

extern (C) void __gmpz_fdiv_r_2exp (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_fdiv_r_2exp mpz_fdiv_r_2exp;

extern (C) gmp_ulong __gmpz_fdiv_r_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_fdiv_r_ui mpz_fdiv_r_ui;

extern (C) gmp_ulong __gmpz_fdiv_ui (inout mpz_t, gmp_ulong);
alias __gmpz_fdiv_ui mpz_fdiv_ui;

extern (C) void __gmpz_fib_ui (inout mpz_t, gmp_ulong);
alias __gmpz_fib_ui mpz_fib_ui;

extern (C) void __gmpz_fib2_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_fib2_ui mpz_fib2_ui;

extern (C) int __gmpz_fits_sint_p (inout mpz_t);
alias __gmpz_fits_sint_p mpz_fits_sint_p;

extern (C) int __gmpz_fits_slong_p (inout mpz_t);
alias __gmpz_fits_slong_p mpz_fits_slong_p;

extern (C) int __gmpz_fits_sshort_p (inout mpz_t);
alias __gmpz_fits_sshort_p mpz_fits_sshort_p;

extern (C) int __gmpz_fits_uint_p (inout mpz_t);
alias __gmpz_fits_uint_p mpz_fits_uint_p;

extern (C) int __gmpz_fits_gmp_ulong_p (inout mpz_t);
alias __gmpz_fits_gmp_ulong_p mpz_fits_gmp_ulong_p;

extern (C) int __gmpz_fits_ushort_p (inout mpz_t);
alias __gmpz_fits_ushort_p mpz_fits_ushort_p;

extern (C) void __gmpz_gcd (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_gcd mpz_gcd;

extern (C) gmp_ulong __gmpz_gcd_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_gcd_ui mpz_gcd_ui;

extern (C) void __gmpz_gcdext (inout mpz_t, inout mpz_t, inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_gcdext mpz_gcdext;

extern (C) double __gmpz_get_d (inout mpz_t);
alias __gmpz_get_d mpz_get_d;

extern (C) double __gmpz_get_d_2exp (out gmp_long, inout mpz_t);
alias __gmpz_get_d_2exp mpz_get_d_2exp;

extern (C) gmp_long __gmpz_get_si (inout mpz_t);
alias __gmpz_get_si mpz_get_si;

extern (C) char *__gmpz_get_str (char *, int, inout mpz_t);
alias __gmpz_get_str mpz_get_str;

extern (C) gmp_ulong __gmpz_get_ui (inout mpz_t);
alias __gmpz_get_ui mpz_get_ui;

extern (C) mp_limb_t __gmpz_getlimbn (inout mpz_t, mp_size_t);
alias __gmpz_getlimbn mpz_getlimbn;

extern (C) gmp_ulong __gmpz_hamdist (inout mpz_t, inout mpz_t);
alias __gmpz_hamdist mpz_hamdist;

extern (C) void __gmpz_import (inout mpz_t, size_t, int, size_t, int, size_t, void *);
alias __gmpz_import mpz_import;

extern (C) void __gmpz_init (inout mpz_t);
alias __gmpz_init mpz_init;

extern (C) void __gmpz_init2 (inout mpz_t, gmp_ulong);
alias __gmpz_init2 mpz_init2;

extern (C) void __gmpz_init_set (inout mpz_t, inout mpz_t);
alias __gmpz_init_set mpz_init_set;

extern (C) void __gmpz_init_set_d (inout mpz_t, double);
alias __gmpz_init_set_d mpz_init_set_d;

extern (C) void __gmpz_init_set_si (inout mpz_t, gmp_long);
alias __gmpz_init_set_si mpz_init_set_si;

extern (C) int __gmpz_init_set_str (inout mpz_t, char *, int);
alias __gmpz_init_set_str mpz_init_set_str;

extern (C) void __gmpz_init_set_ui (inout mpz_t, gmp_ulong);
alias __gmpz_init_set_ui mpz_init_set_ui;

version (_GMP_H_HAVE_FILE) {
    extern (C) size_t __gmpz_inp_raw (inout mpz_t, FILE *);
    alias __gmpz_inp_raw mpz_inp_raw;
}

version (_GMP_H_HAVE_FILE) {
    extern (C) size_t __gmpz_inp_str (inout mpz_t, FILE *, int);
    alias __gmpz_inp_str mpz_inp_str;
}

extern (C) int __gmpz_invert (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_invert mpz_invert;

extern (C) void __gmpz_ior (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_ior mpz_ior;

extern (C) int __gmpz_jacobi (inout mpz_t, inout mpz_t);
alias __gmpz_jacobi mpz_jacobi;

alias mpz_jacobi mpz_kronecker;

extern (C) int __gmpz_kronecker_si (inout mpz_t, gmp_long);
alias __gmpz_kronecker_si mpz_kronecker_si;

extern (C) int __gmpz_kronecker_ui (inout mpz_t, gmp_ulong);
alias __gmpz_kronecker_ui mpz_kronecker_ui;

extern (C) int __gmpz_si_kronecker (gmp_long, inout mpz_t);
alias __gmpz_si_kronecker mpz_si_kronecker;

extern (C) int __gmpz_ui_kronecker (gmp_ulong, inout mpz_t);
alias __gmpz_ui_kronecker mpz_ui_kronecker;

extern (C) void __gmpz_lcm (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_lcm mpz_lcm;

extern (C) void __gmpz_lcm_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_lcm_ui mpz_lcm_ui;

alias mpz_jacobi mpz_legendre;

extern (C) void __gmpz_lucnum_ui (inout mpz_t, gmp_ulong);
alias __gmpz_lucnum_ui mpz_lucnum_ui;

extern (C) void __gmpz_lucnum2_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_lucnum2_ui mpz_lucnum2_ui;

extern (C) int __gmpz_millerrabin (inout mpz_t, int);
alias __gmpz_millerrabin mpz_millerrabin;

extern (C) void __gmpz_mod (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_mod mpz_mod;

extern (C) void __gmpz_mul (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_mul mpz_mul;

extern (C) void __gmpz_mul_2exp (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_mul_2exp mpz_mul_2exp;

extern (C) void __gmpz_mul_si (inout mpz_t, inout mpz_t, gmp_long);
alias __gmpz_mul_si mpz_mul_si;

extern (C) void __gmpz_mul_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_mul_ui mpz_mul_ui;

extern (C) void __gmpz_neg (inout mpz_t, inout mpz_t);
alias __gmpz_neg mpz_neg;

extern (C) void __gmpz_nextprime (inout mpz_t, inout mpz_t);
alias __gmpz_nextprime mpz_nextprime;

version (_GMP_H_HAVE_FILE) {
    extern (C) size_t __gmpz_out_raw (FILE *, inout mpz_t);
    alias __gmpz_out_raw mpz_out_raw;
}

version (_GMP_H_HAVE_FILE) {
    extern (C) size_t __gmpz_out_str (FILE *, int, inout mpz_t);
    alias __gmpz_out_str mpz_out_str;
}

extern (C) int __gmpz_perfect_power_p (inout mpz_t);
alias __gmpz_perfect_power_p mpz_perfect_power_p;

extern (C) int __gmpz_perfect_square_p (inout mpz_t);
alias __gmpz_perfect_square_p mpz_perfect_square_p;

extern (C) gmp_ulong __gmpz_popcount (inout mpz_t);
alias __gmpz_popcount mpz_popcount;

extern (C) void __gmpz_pow_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_pow_ui mpz_pow_ui;

extern (C) void __gmpz_powm (inout mpz_t, inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_powm mpz_powm;

extern (C) void __gmpz_powm_ui (inout mpz_t, inout mpz_t, gmp_ulong, inout mpz_t);
alias __gmpz_powm_ui mpz_powm_ui;

extern (C) int __gmpz_probab_prime_p (inout mpz_t, int);
alias __gmpz_probab_prime_p mpz_probab_prime_p;

extern (C) void __gmpz_random (inout mpz_t, mp_size_t);
alias __gmpz_random mpz_random;

extern (C) void __gmpz_random2 (inout mpz_t, mp_size_t);
alias __gmpz_random2 mpz_random2;

extern (C) void __gmpz_realloc2 (inout mpz_t, gmp_ulong);
alias __gmpz_realloc2 mpz_realloc2;

extern (C) gmp_ulong __gmpz_remove (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_remove mpz_remove;

extern (C) int __gmpz_root (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_root mpz_root;

extern (C) void __gmpz_rrandomb (inout mpz_t, inout gmp_randstate_t, gmp_ulong);
alias __gmpz_rrandomb mpz_rrandomb;

extern (C) gmp_ulong __gmpz_scan0 (inout mpz_t, gmp_ulong);
alias __gmpz_scan0 mpz_scan0;

extern (C) gmp_ulong __gmpz_scan1 (inout mpz_t, gmp_ulong);
alias __gmpz_scan1 mpz_scan1;

extern (C) void __gmpz_set (inout mpz_t, inout mpz_t);
alias __gmpz_set mpz_set;

extern (C) void __gmpz_set_d (inout mpz_t, double);
alias __gmpz_set_d mpz_set_d;

extern (C) void __gmpz_set_f (inout mpz_t, inout mpf_t);
alias __gmpz_set_f mpz_set_f;

extern (C) void __gmpz_set_q (inout mpz_t, inout mpq_t);
alias __gmpz_set_q mpz_set_q;

extern (C) void __gmpz_set_si (inout mpz_t, gmp_long);
alias __gmpz_set_si mpz_set_si;

extern (C) int __gmpz_set_str (inout mpz_t, char *, int);
alias __gmpz_set_str mpz_set_str;

extern (C) void __gmpz_set_ui (inout mpz_t, gmp_ulong);
alias __gmpz_set_ui mpz_set_ui;

extern (C) void __gmpz_setbit (inout mpz_t, gmp_ulong);
alias __gmpz_setbit mpz_setbit;

extern (C) size_t __gmpz_size (inout mpz_t);
alias __gmpz_size mpz_size;

extern (C) size_t __gmpz_sizeinbase (inout mpz_t, int);
alias __gmpz_sizeinbase mpz_sizeinbase;

extern (C) void __gmpz_sqrt (inout mpz_t, inout mpz_t);
alias __gmpz_sqrt mpz_sqrt;

extern (C) void __gmpz_sqrtrem (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_sqrtrem mpz_sqrtrem;

extern (C) void __gmpz_sub (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_sub mpz_sub;

extern (C) void __gmpz_sub_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_sub_ui mpz_sub_ui;

extern (C) void __gmpz_ui_sub (inout mpz_t, uint, inout mpz_t);
alias __gmpz_ui_sub mpz_ui_sub;

extern (C) void __gmpz_submul (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_submul mpz_submul;

extern (C) void __gmpz_submul_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_submul_ui mpz_submul_ui;

extern (C) void __gmpz_swap (inout mpz_t, inout mpz_t);
alias __gmpz_swap mpz_swap;

extern (C) gmp_ulong __gmpz_tdiv_ui (inout mpz_t, gmp_ulong);
alias __gmpz_tdiv_ui mpz_tdiv_ui;

extern (C) void __gmpz_tdiv_q (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_tdiv_q mpz_tdiv_q;

extern (C) void __gmpz_tdiv_q_2exp (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_tdiv_q_2exp mpz_tdiv_q_2exp;

extern (C) gmp_ulong __gmpz_tdiv_q_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_tdiv_q_ui mpz_tdiv_q_ui;

extern (C) void __gmpz_tdiv_qr (inout mpz_t, inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_tdiv_qr mpz_tdiv_qr;

extern (C) gmp_ulong __gmpz_tdiv_qr_ui (inout mpz_t, inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_tdiv_qr_ui mpz_tdiv_qr_ui;

extern (C) void __gmpz_tdiv_r (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_tdiv_r mpz_tdiv_r;

extern (C) void __gmpz_tdiv_r_2exp (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_tdiv_r_2exp mpz_tdiv_r_2exp;

extern (C) gmp_ulong __gmpz_tdiv_r_ui (inout mpz_t, inout mpz_t, gmp_ulong);
alias __gmpz_tdiv_r_ui mpz_tdiv_r_ui;

extern (C) int __gmpz_tstbit (inout mpz_t, gmp_ulong);
alias __gmpz_tstbit mpz_tstbit;

extern (C) void __gmpz_ui_pow_ui (inout mpz_t, gmp_ulong, gmp_ulong);
alias __gmpz_ui_pow_ui mpz_ui_pow_ui;

extern (C) void __gmpz_urandomb (inout mpz_t, inout gmp_randstate_t, gmp_ulong);
alias __gmpz_urandomb mpz_urandomb;

extern (C) void __gmpz_urandomm (inout mpz_t, inout gmp_randstate_t, inout mpz_t);
alias __gmpz_urandomm mpz_urandomm;

extern (C) void __gmpz_xor (inout mpz_t, inout mpz_t, inout mpz_t);
alias __gmpz_xor mpz_xor;
alias __gmpz_xor mpz_eor;

/**************** Rational (i.e. Q) routines.  ****************/

extern (C) void __gmpq_abs (inout mpq_t, inout mpq_t);
alias __gmpq_abs mpq_abs;

extern (C) void __gmpq_add (inout mpq_t, inout mpq_t, inout mpq_t);
alias __gmpq_add mpq_add;

extern (C) void __gmpq_canonicalize (inout mpq_t);
alias __gmpq_canonicalize mpq_canonicalize;

extern (C) void __gmpq_clear (inout mpq_t);
alias __gmpq_clear mpq_clear;

extern (C) int __gmpq_cmp (inout mpq_t, inout mpq_t);
alias __gmpq_cmp mpq_cmp;

extern (C) int __gmpq_cmp_si (inout mpq_t, gmp_long, gmp_ulong);
alias __gmpq_cmp_si mpq_cmp_si;

extern (C) int __gmpq_cmp_ui (inout mpq_t, gmp_ulong, gmp_ulong);
alias __gmpq_cmp_ui mpq_cmp_ui;

extern (C) void __gmpq_div (inout mpq_t, inout mpq_t, inout mpq_t);
alias __gmpq_div mpq_div;

extern (C) void __gmpq_div_2exp (inout mpq_t, inout mpq_t, gmp_ulong);
alias __gmpq_div_2exp mpq_div_2exp;

extern (C) int __gmpq_equal (inout mpq_t, inout mpq_t);
alias __gmpq_equal mpq_equal;

extern (C) void __gmpq_get_num (inout mpz_t, inout mpq_t);
alias __gmpq_get_num mpq_get_num;

extern (C) void __gmpq_get_den (inout mpz_t, inout mpq_t);
alias __gmpq_get_den mpq_get_den;

extern (C) double __gmpq_get_d (inout mpq_t);
alias __gmpq_get_d mpq_get_d;

extern (C) char *__gmpq_get_str (char *, int, inout mpq_t);
alias __gmpq_get_str mpq_get_str;

extern (C) void __gmpq_init (inout mpq_t);
alias __gmpq_init mpq_init;

version(_GMP_H_HAVE_FILE) {
    extern (C) size_t __gmpq_inp_str (inout mpq_t, FILE *, int);
    alias __gmpq_inp_str mpq_inp_str;
}

extern (C) void __gmpq_inv (inout mpq_t, inout mpq_t);
alias __gmpq_inv mpq_inv;

extern (C) void __gmpq_mul (inout mpq_t, inout mpq_t, inout mpq_t);
alias __gmpq_mul mpq_mul;

extern (C) void __gmpq_mul_2exp (inout mpq_t, inout mpq_t, gmp_ulong);
alias __gmpq_mul_2exp mpq_mul_2exp;

extern (C) void __gmpq_neg (inout mpq_t, inout mpq_t);
alias __gmpq_neg mpq_neg;

version(_GMP_H_HAVE_FILE) {
    extern (C) size_t __gmpq_out_str (FILE *, int, inout mpq_t);
    alias __gmpq_out_str mpq_out_str;
}

extern (C) void __gmpq_set (inout mpq_t, inout mpq_t);
alias __gmpq_set mpq_set;

extern (C) void __gmpq_set_d (inout mpq_t, double);
alias __gmpq_set_d mpq_set_d;

extern (C) void __gmpq_set_den (inout mpq_t, inout mpz_t);
alias __gmpq_set_den mpq_set_den;

extern (C) void __gmpq_set_f (inout mpq_t, inout mpf_t);
alias __gmpq_set_f mpq_set_f;

extern (C) void __gmpq_set_num (inout mpq_t, inout mpz_t);
alias __gmpq_set_num mpq_set_num;

extern (C) void __gmpq_set_si (inout mpq_t, gmp_long, gmp_ulong);
alias __gmpq_set_si mpq_set_si;

extern (C) int __gmpq_set_str (inout mpq_t, char *, int);
alias __gmpq_set_str mpq_set_str;

extern (C) void __gmpq_set_ui (inout mpq_t, gmp_ulong, gmp_ulong);
alias __gmpq_set_ui mpq_set_ui;

extern (C) void __gmpq_set_z (inout mpq_t, inout mpz_t);
alias __gmpq_set_z mpq_set_z;

extern (C) void __gmpq_sub (inout mpq_t, inout mpq_t, inout mpq_t);
alias __gmpq_sub mpq_sub;

extern (C) void __gmpq_swap (inout mpq_t, inout mpq_t);
alias __gmpq_swap mpq_swap;


/**************** Float (i.e. F) routines.  ****************/

extern (C) void __gmpf_abs (inout mpf_t, inout mpf_t);
alias __gmpf_abs mpf_abs;

extern (C) void __gmpf_add (inout mpf_t, inout mpf_t, inout mpf_t);
alias __gmpf_add mpf_add;

extern (C) void __gmpf_add_ui (inout mpf_t, inout mpf_t, gmp_ulong);
alias __gmpf_add_ui mpf_add_ui;

extern (C) void __gmpf_ceil (inout mpf_t, inout mpf_t);
alias __gmpf_ceil mpf_ceil;

extern (C) void __gmpf_clear (inout mpf_t);
alias __gmpf_clear mpf_clear;

extern (C) int __gmpf_cmp (inout mpf_t, inout mpf_t);
alias __gmpf_cmp mpf_cmp;

extern (C) int __gmpf_cmp_d (inout mpf_t, double);
alias __gmpf_cmp_d mpf_cmp_d;

extern (C) int __gmpf_cmp_si (inout mpf_t, gmp_long);
alias __gmpf_cmp_si mpf_cmp_si;

extern (C) int __gmpf_cmp_ui (inout mpf_t, gmp_ulong);
alias __gmpf_cmp_ui mpf_cmp_ui;

extern (C) void __gmpf_div (inout mpf_t, inout mpf_t, inout mpf_t);
alias __gmpf_div mpf_div;

extern (C) void __gmpf_div_2exp (inout mpf_t, inout mpf_t, gmp_ulong);
alias __gmpf_div_2exp mpf_div_2exp;

extern (C) void __gmpf_div_ui (inout mpf_t, inout mpf_t, gmp_ulong);
alias __gmpf_div_ui mpf_div_ui;

extern (C) void __gmpf_dump (inout mpf_t);
alias __gmpf_dump mpf_dump;

extern (C) int __gmpf_eq (inout mpf_t, inout mpf_t, gmp_ulong);
alias __gmpf_eq mpf_eq;

extern (C) int __gmpf_fits_sint_p (inout mpf_t);
alias __gmpf_fits_sint_p mpf_fits_sint_p;

extern (C) int __gmpf_fits_slong_p (inout mpf_t);
alias __gmpf_fits_slong_p mpf_fits_slong_p;

extern (C) int __gmpf_fits_sshort_p (inout mpf_t);
alias __gmpf_fits_sshort_p mpf_fits_sshort_p;

extern (C) int __gmpf_fits_uint_p (inout mpf_t);
alias __gmpf_fits_uint_p mpf_fits_uint_p;

extern (C) int __gmpf_fits_gmp_ulong_p (inout mpf_t);
alias __gmpf_fits_gmp_ulong_p mpf_fits_gmp_ulong_p;

extern (C) int __gmpf_fits_ushort_p (inout mpf_t);
alias __gmpf_fits_ushort_p mpf_fits_ushort_p;

extern (C) void __gmpf_floor (inout mpf_t, inout mpf_t);
alias __gmpf_floor mpf_floor;

extern (C) double __gmpf_get_d (inout mpf_t);
alias __gmpf_get_d mpf_get_d;

extern (C) double __gmpf_get_d_2exp (out gmp_long, inout mpf_t);
alias __gmpf_get_d_2exp mpf_get_d_2exp;

extern (C) gmp_ulong __gmpf_get_default_prec ();
alias __gmpf_get_default_prec mpf_get_default_prec;

extern (C) gmp_ulong __gmpf_get_prec (inout mpf_t);
alias __gmpf_get_prec mpf_get_prec;

extern (C) gmp_long __gmpf_get_si (inout mpf_t);
alias __gmpf_get_si mpf_get_si;

extern (C) char *__gmpf_get_str (char *, mp_exp_t *, int, size_t, inout mpf_t);
alias __gmpf_get_str mpf_get_str;

extern (C) gmp_ulong __gmpf_get_ui (inout mpf_t);
alias __gmpf_get_ui mpf_get_ui;

extern (C) void __gmpf_init (inout mpf_t);
alias __gmpf_init mpf_init;

extern (C) void __gmpf_init2 (inout mpf_t, gmp_ulong);
alias __gmpf_init2 mpf_init2;

extern (C) void __gmpf_init_set (inout mpf_t, inout mpf_t);
alias __gmpf_init_set mpf_init_set;

extern (C) void __gmpf_init_set_d (inout mpf_t, double);
alias __gmpf_init_set_d mpf_init_set_d;

extern (C) void __gmpf_init_set_si (inout mpf_t, gmp_long);
alias __gmpf_init_set_si mpf_init_set_si;

extern (C) int __gmpf_init_set_str (inout mpf_t, char *, int);
alias __gmpf_init_set_str mpf_init_set_str;

extern (C) void __gmpf_init_set_ui (inout mpf_t, gmp_ulong);
alias __gmpf_init_set_ui mpf_init_set_ui;

version (_GMP_H_HAVE_FILE) {
    extern (C) size_t __gmpf_inp_str (inout mpf_t, FILE *, int);
    alias __gmpf_inp_str mpf_inp_str;
}

extern (C) int __gmpf_integer_p (inout mpf_t);
alias __gmpf_integer_p mpf_integer_p;

extern (C) void __gmpf_mul (inout mpf_t, inout mpf_t, inout mpf_t);
alias __gmpf_mul mpf_mul;

extern (C) void __gmpf_mul_2exp (inout mpf_t, inout mpf_t, gmp_ulong);
alias __gmpf_mul_2exp mpf_mul_2exp;

extern (C) void __gmpf_mul_ui (inout mpf_t, inout mpf_t, gmp_ulong);
alias __gmpf_mul_ui mpf_mul_ui;

extern (C) void __gmpf_neg (inout mpf_t, inout mpf_t);
alias __gmpf_neg mpf_neg;

version (_GMP_H_HAVE_FILE) {
    extern (C) size_t __gmpf_out_str (FILE *, int, size_t, inout mpf_t);
    alias __gmpf_out_str mpf_out_str;
}

extern (C) void __gmpf_pow_ui (inout mpf_t, inout mpf_t, gmp_ulong);
alias __gmpf_pow_ui mpf_pow_ui;

extern (C) void __gmpf_random2 (inout mpf_t, mp_size_t, mp_exp_t);
alias __gmpf_random2 mpf_random2;

extern (C) void __gmpf_reldiff (inout mpf_t, inout mpf_t, inout mpf_t);
alias __gmpf_reldiff mpf_reldiff;

extern (C) void __gmpf_set (inout mpf_t, inout mpf_t);
alias __gmpf_set mpf_set;

extern (C) void __gmpf_set_d (inout mpf_t, double);
alias __gmpf_set_d mpf_set_d;

extern (C) void __gmpf_set_default_prec (gmp_ulong);
alias __gmpf_set_default_prec mpf_set_default_prec;

extern (C) void __gmpf_set_prec (inout mpf_t, gmp_ulong);
alias __gmpf_set_prec mpf_set_prec;

extern (C) void __gmpf_set_prec_raw (inout mpf_t, gmp_ulong);
alias __gmpf_set_prec_raw mpf_set_prec_raw;

extern (C) void __gmpf_set_q (inout mpf_t, inout mpq_t);
alias __gmpf_set_q mpf_set_q;

extern (C) void __gmpf_set_si (inout mpf_t, gmp_long);
alias __gmpf_set_si mpf_set_si;

extern (C) int __gmpf_set_str (inout mpf_t, char *, int);
alias __gmpf_set_str mpf_set_str;

extern (C) void __gmpf_set_ui (inout mpf_t, gmp_ulong);
alias __gmpf_set_ui mpf_set_ui;

extern (C) void __gmpf_set_z (inout mpf_t, inout mpz_t);
alias __gmpf_set_z mpf_set_z;

extern (C) size_t __gmpf_size (inout mpf_t);
alias __gmpf_size mpf_size;

extern (C) void __gmpf_sqrt (inout mpf_t, inout mpf_t);
alias __gmpf_sqrt mpf_sqrt;

extern (C) void __gmpf_sqrt_ui (inout mpf_t, gmp_ulong);
alias __gmpf_sqrt_ui mpf_sqrt_ui;

extern (C) void __gmpf_sub (inout mpf_t, inout mpf_t, inout mpf_t);
alias __gmpf_sub mpf_sub;

extern (C) void __gmpf_sub_ui (inout mpf_t, inout mpf_t, gmp_ulong);
alias __gmpf_sub_ui mpf_sub_ui;

extern (C) void __gmpf_swap (inout mpf_t, inout mpf_t);
alias __gmpf_swap mpf_swap;

extern (C) void __gmpf_trunc (inout mpf_t, inout mpf_t);
alias __gmpf_trunc mpf_trunc;

extern (C) void __gmpf_ui_div (inout mpf_t, gmp_ulong, inout mpf_t);
alias __gmpf_ui_div mpf_ui_div;

extern (C) void __gmpf_ui_sub (inout mpf_t, gmp_ulong, inout mpf_t);
alias __gmpf_ui_sub mpf_ui_sub;

extern (C) void __gmpf_urandomb (inout mpf_t, inout gmp_randstate_t, gmp_ulong);
alias __gmpf_urandomb mpf_urandomb;

enum
{
  GMP_ERROR_NONE = 0,
  GMP_ERROR_UNSUPPORTED_ARGUMENT = 1,
  GMP_ERROR_DIVISION_BY_ZERO = 2,
  GMP_ERROR_SQRT_OF_NEGATIVE = 4,
  GMP_ERROR_INVALID_ARGUMENT = 8,
  GMP_ERROR_ALLOCATE = 16,
  GMP_ERROR_BAD_STRING = 32,
  GMP_ERROR_UNUSED_ERROR
};

/* Major version number is the value of __GNU_MP__ too, above and in mp.h. */
const int __GNU_MP_VERSION = 4;
const int __GNU_MP_VERSION_MINOR = 1;
const int __GNU_MP_VERSION_PATCHLEVEL = 2;

