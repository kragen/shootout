!
! The Great Computer Language Shootout
! http://shootout.alioth.debian.org/
!
! Contributed by Sebastien Loisel
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
! This version uses the traditional central-difference approximation to f'
!
! Summary of classes:
!
! fl -- low precision floating point type
! mycomplex -- complex numbers whose real and imaginary parts can be fl
! trapezoid_method_rooter -- implements the function that the trapezoid method
!                            must solve

program implicitode
  use function_params
  implicit none

  real*8, external  :: mysqrt, rat, simple
  real*8            :: res
  type(fdata)       :: gparams
  type(fdata)       :: tparams
  character(len=33) :: str
  real*8            :: x, dt, y0, r, u_t0, t1, t0
  integer           :: i,n,ns
  character(len=8)  :: argv

  call getarg(1,argv)
  if (len(trim(argv)) == 0) then
     n = 50
  else
     read(argv,*) n
  end if
  x = rat(0.25d0)
  res = D(rat,0.25d0)
  write(*,'(2(a,es27.20e2))') 'rational_taylor_series: ',x,' ',res

  gparams%a = 2.0d0
  x = newton(mysqrt,gparams,1.0d0,10)
  write(*,'(2(a,es27.20e2))') 'newton-sqrt_2:',x
  x = newton(rat,gparams,-1.0d0,6)
  res = rat(x)
  write(*,'(a,es27.20e2)') 'newton-rat: ',x
  !
  ! Simple case that enables easy verification of the trapezoidal implementation:
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
  write(*,'(a,es27.20e2)') 'u(6) = ',r
  call rk4(simple,gparams,t0,dt,u_t0,n,r)
  write(*,'(a,es27.20e2)') 'u(6) = ',r

  x = 1.0d0
  dt = 0.02d0
  y0 = 1.0d0/(4*n)
!  call integrate_functions(x,dt,y0,4*n)

contains
  
  subroutine integrate_functions(t0,dt,y0,n)
    real*8, intent(in)  :: t0
    real*8, intent(in)  :: dt
    real*8, intent(in)  :: y0
    integer, intent(in) :: n
    call trapezoidal(mysqrt,gparams,x,dt,y0,n,r)
    print *, 'trap 1: ',r
    call rk4(mysqrt,gparams,x,dt,y0,n,r)
    print *, 'rk4 1: ',r
    call trapezoidal(rat,gparams,x,dt,y0,n,r)
    print *, 'i2: ',r
  end subroutine integrate_functions

  subroutine trapezoidal(g,gparams,t0,dt,y0,numsteps,r)
    real*8, external      :: g
    type(fdata), intent(in)         :: gparams
    real*8, intent(in)    :: t0
    real*8, intent(in)    :: dt
    real*8, intent(in)    :: y0
    integer, intent(in)             :: numsteps
    real*8, intent(inout) :: r

    real*8                :: y, y1
    integer                         :: i, j
    real*8                :: t1
    !    (u[k+1]-u[k])=(f(t[k],u[k])+f(t[k]+dt,u[k+1]))*dt/2,
    y = y0
    do i=1,numsteps
       t1 = t0 + i*dt
       y1 = y
       do j=1,10
          y1 = y1 - ((g(y,gparams) + g(y1,gparams))*(dt/2.0d0) + y - y1)/(D(g,y1,gparams)*(dt/2.0d0) - 1.0d0)
       end do
       y = y1
    end do
    r = y
  end subroutine trapezoidal

  subroutine rk4(g,gparams,t0,dt,y0,numsteps,r)
    real*8, external      :: g
    type(fdata), intent(in)         :: gparams
    real*8, intent(in)    :: t0
    real*8, intent(in)    :: dt
    real*8, intent(in)    :: y0
    integer, intent(in)             :: numsteps
    real*8, intent(inout) :: r

    real*8                :: y, y1
    integer                         :: i, j
    real*8                :: t1
    real*8                :: k1, k2, k3, k4
    !
    ! u[k+1] = u[k] + k1/6 + k2/3 + k3/3 + k4/6
    !
    ! k1 = h*f(t[n]    ,u[k])
    !
    ! k2 = h*f(t[n]+h/2,u[n]+k1/2)
    !
    ! k3 = h*f(t[n]+h/2,u[n]+k2/2)
    !
    ! k4 = h*f(t[n]+h  ,u[n]+k3)
    !
    y = y0
    do i=1,numsteps
       t1 = t0 + i*dt
       k1 = dt*g(y,gparams)
       k2 = dt*g(y+0.5d0*k1,gparams)
       k3 = dt*g(y+0.5d0*k2,gparams)
       k4 = dt*g(y,k3,gparams)
       y1 = y + (k1 + 2*k2 + 2*k3 + k4)/6
       y = y1
    end do
    r = y

  end subroutine rk4

  subroutine irk4(g,gparams,t0,dt,y0,numsteps,r)
    ! Hammer-Hollingsworth
    real*8, external        :: g
    type(fdata), intent(in) :: gparams
    real*8, intent(in)      :: t0
    real*8, intent(in)      :: dt
    real*8, intent(in)      :: y0
    integer, intent(in)     :: numsteps
    real*8, intent(inout)   :: r

    real*8                  :: y, y1
    integer                 :: i, j
    real*8                  :: t1
    real*8                  :: k1, k2, k3, k4, c1, c2, b1, b2
    real*8, dimension(2,2)  :: A
    real*8, dimension(2)    :: b, c, k, ks
    !
    ! u[k+1] = u[k] + h * _b_ . _k_
    !
    ! k[i] = f(t0+c[i]*h, y0 + A[i]*_k_)
    !
    c = (/ (3-sqrt(3.0d0))/6 , (3+sqrt(3.0d0))/6 /)
    b = (/0.5d0 , 0.5d0/)
    A = reshape((/0.25d0,0.25d0-sqrt(3.0d0)/6,0.25d0+sqrt(3.0d0)/6,0.25d0/),(/2,2/))
    y = y0
    do i=1,numsteps
       t1 = t0 + i*dt
       do j=1,10

       end do
       y1 = y + dt*dot_product(b,k)
       y = y1
    end do
    r = y

  end subroutine irk4

  real*8 function newton(g,params,x,n)
    real*8, external                  :: g
    real*8, intent(in)                :: x
    type(fdata), optional, intent(in) :: params
    integer, optional, intent(in)     :: n
    integer :: i
    if (present(n)) then
       ns = n
    else
       ns = 10
    end if
    newton = x
    do i=1,ns
       newton = newton - g(newton,params)/D(g,newton,params)
    end do
  end function newton

  real*8 function D(g,x,params,step)
    ! Calculate the central-difference approximation to g'(x)
    real*8, external                  :: g
    real*8, intent(in)                :: x
    type(fdata), intent(in), optional :: params
    real*8, intent(in), optional      :: step
    real*8, parameter                 :: fstep = 1.0d-6
    real*8                            :: lstep
    if (present(step)) then
       lstep = step
    else
       lstep = fstep
    end if
    D = (g(x+0.5d0*lstep,params) -  g(x-0.5d0*lstep,params))/lstep
  end function D

end program implicitode


real*8 function rat(x, params)
  use function_params

  real*8, intent(in) :: x
  type(fdata), intent(in), optional :: params

  rat = (1 + 2*x + 3*x**2 + 7*x**6 + 5*x**11) / (2 + 5*x - 6*x**3 - 3*x**7)

end function rat

real*8 function mysqrt(x, params)
  use function_params

  real*8, intent(in)    :: x
  type(fdata), intent(in), optional :: params
  mysqrt = x*x - params%a
end function mysqrt

real*8 function simple(x, params)
  use function_params

  real*8, intent(in)    :: x
  type(fdata), intent(in), optional :: params

  simple = 0.5d0/x
end function simple
