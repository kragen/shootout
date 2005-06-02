!
! The Great Computer Language Shootout
! http://shootout.alioth.debian.org/
!
! Contributed by Sebastien Loisel
!
! Fortran version by Simon Geard and Arjen Markus
!
! OVERVIEW: In this test, we solve an ordinary differential equation
!    u'=f(t,u)
! using the Trapezoid numerical method, which can be written as
!    (u[k+1]-u[k])=(f(t[k],u[k])+f(t[k]+dt,u[k+1]))*dt/2,
! where t[k], u[k], dt and the function f are known and u[k+1] is the
! unknown.
!
! Since u[k+1] appears on both sides of the equation, we use an iterative
! solver called the newton iteration to compute u[k+1]. The newton iteration
! computes the solution to
!    h(x)=0
! where h is a known function and x is the unknown 0 of h, using the method
!    x[k+1]=x[k]-f(x[k])/f'(x[k]).
! Here, f' denotes the derivative of f.
!
! To compute f' from the definition of f alone, we use a technique called
! automatic differentiation. This works by replacing all floating point
! variables by a special type we call ad (for automatic differentiation.)
! If the python program for f is called with parameter x of type ad,
! it will do the same work as if it were called with the equivalent parameter
! of type floating point, but will also return f'. That's why it's called
! "automatic."
!
! To shake things up, we also have another type, fl (for "float") which
! works exactly like a double precision floating point, but with much
! less precision.
!
! Summary of classes:
!
! ad -- automatic differentiation type
! fl -- low precision floating point type
! mycomplex -- complex numbers whose real and imaginary parts can be fl
! trapezoid_method_rooter -- implements the function that the trapezoid method
!                            must solve

program implicitode
  use function_params
  use autoDiff
  implicit none

  type(ad), external :: mysqrt, rat, simple
  type(ad)    :: res
  type(fdata) :: gparams
  type(fdata) :: tparams
  character(len=33) :: str
  real*8  :: x, dt, y0, r, u_t0, t1, t0
  complex*8 :: xc
  integer :: i,n,ns
  character(len=8) argv

  call getarg(1,argv)
  if (len(trim(argv)) == 0) then
     n = 50
  else
     read(argv,*) n
  end if

  res = rat(ad(0.25d0,1))
  write(*,'(2(a,es20.14e2))') 'rational_taylor_series: ',res%x,' ',res%dx

  gparams%a = 2.0d0
  x = newton(mysqrt,gparams,ad(1.0d0,0.0d0),10)
  write(*,'(2(a,es21.14e2))') 'newton-sqrt_2:',x
  x = newton(rat,gparams,ad(-1.0d0,0.0d0),6)
  res = rat(ad(x,0))
  write(*,'(a,es21.14e2)') 'newton-rat: ',x

  !
  ! Simple case that is easy to check:
  !
  !              u' = 1/(2u) with u(1) = 2
  !
  !           => u = sqrt(t+3)
  !
  ! so the test is to ensure u(6) = 3
  !
  t0 = 1.0d0            ! Initial value of the parameter
  u_t0 = 2.0d0          ! Value of u at t0: u(1) = 2
  t1 = 6.0d0            ! Final (target) value of parameter t
  dt = (t1 - t0)/n      ! Parameter step size
  call trapezoidal(simple,gparams,t0,dt,u_t0,n,r)
  write(*,'(a,es17.10e2)') 'u(6) = ',r

  x = 1.0d0
  dt = 0.02d0
  y0 = 1.0d0/(4*n)
  call integrate_functions(x,dt,y0,4*n)

contains
  
  subroutine integrate_functions(t0,dt,y0,n)
    real*8, intent(in)  :: t0
    real*8, intent(in)  :: dt
    real*8, intent(in)  :: y0
    integer, intent(in) :: n
    call trapezoidal(mysqrt,gparams,x,dt,y0,n,r)
    print *, 'i1: ',r
    call trapezoidal(rat,gparams,x,dt,y0,n,r)
    print *, 'i2: ',r
  end subroutine integrate_functions

  subroutine trapezoidal(g,gparams,t0,dt,y0,numsteps,r)
    type(ad), external        :: g
    type(fdata), intent(in) :: gparams
    real*8, intent(in)      :: t0
    real*8, intent(in)      :: dt
    real*8, intent(in)      :: y0
    integer, intent(in)     :: numsteps
    real*8, intent(inout)   :: r

    real*8                  :: t, y
    real*8, external        :: trapezoid_method
    type(fdata)             :: params
    type(ad)                :: val, y1
    integer                 :: i, j
    real*8                  :: t1
    !    (u[k+1]-u[k])=(f(t[k],u[k])+f(t[k]+dt,u[k+1]))*dt/2,
    y = y0
    do i=1,numsteps
       t1 = t0 + i*dt
       y1 = ad(y,1)
       do j=1,10
          val = (g(y,gparams) + g(y1,gparams))*(dt/2.0d0) + y - y1
          y1 = y1 - val%x/val%dx
       end do
       y = y1%x
    end do
    r = y
  end subroutine trapezoidal

  real*8 function newton(g,params,x,n)
    type(ad), external                :: g
    type(ad), intent(in)              :: x
    type(fdata), optional, intent(in) :: params
    integer, optional, intent(in)     :: n
    integer :: i
    type(ad) :: val
    if (present(n)) then
       ns = n
    else
       ns = 10
    end if
    newton = x%x
    do i=1,ns
       val = g(newton,params)
       newton = newton - val%x/val%dx
    end do
  end function newton

  real*8 function newton_trapez(func, params, y0)
    
    f0 = func(y0,params)
    do i = 1,nsteps
       val = trap_impl(func,params,y1,y0,f0)
       y1 = y1 - val%x/val%dx
    enddo
    
    newton = y1
    
  end function newton_trapez

  type(ad) function trap_impl(func, params, y1, y0, f0)
    trap_impl = y1 - (func(y1,params)+f0)*hdelta - y0
  end function trap_impl
  
end program implicitode

type(ad) function rat(x, params)
  use function_params
  use autoDiff

  type(ad), intent(in) :: x
  type(fdata), intent(in), optional :: params

  rat = (1 + 2*x + 3*x**2 + 7*x**6 + 5*x**11) / (2 + 5*x - 6*x**3 - 3*x**7)
end function rat

type(ad) function mysqrt(x, params)
  use function_params
  use autoDiff

  type(ad), intent(in)    :: x
  type(fdata), intent(in), optional :: params
  mysqrt = x*x - params%a
end function mysqrt

type(ad) function simple(x, params)
  use function_params
  use autoDiff

  type(ad), intent(in)    :: x
  type(fdata), intent(in), optional :: params

  simple = 0.5d0/x
end function simple
