! Implementation module for automatic differentiation

module autoDiff
  type ad
     real*8 :: x
     real*8 :: dx
  end type ad
  
  interface assignment(=)
     module procedure assign_ad_ad
     module procedure assign_ad_r
  end interface
  
  interface operator(**)
     module procedure exp_ad_int
  end interface

  interface operator(+)
     module procedure add_ad_ad
     module procedure add_r_ad
     module procedure add_i_ad
     module procedure add_ad_r
  end interface

  interface operator(-)
     module procedure sub_ad_ad
     module procedure sub_r_ad
     module procedure sub_ad_r
  end interface

  interface operator(*)
     module procedure mul_ad_ad
     module procedure mul_r_ad
     module procedure mul_i_ad
     module procedure mul_ad_r
  end interface

  interface operator(/)
     module procedure div_r_ad
     module procedure div_ad_ad
  end interface

contains
  subroutine assign_ad_ad(to, from)
    type(ad), intent(out) :: to
    type(ad), intent(in)  :: from
    to%x = from%x
    to%dx = from%dx
  end subroutine assign_ad_ad

  subroutine assign_ad_r(to, from)
    type(ad), intent(out) :: to
    real*8, intent(in)  :: from
    to%x = from
    to%dx = 0.0d0
  end subroutine assign_ad_r

  type(ad) function add_ad_ad(a, b)
    ! ad's add like vectors
    type(ad), intent(in) :: a, b
    add_ad_ad = ad(a%x+b%x,a%dx+b%dx)
  end function add_ad_ad

  type(ad) function add_r_ad(a, b)
    ! ad's add like vectors
    real*8, intent(in)   :: a
    type(ad), intent(in) :: b
    add_r_ad = ad(a+b%x,b%dx)
  end function add_r_ad

  type(ad) function add_i_ad(a, b)
    ! ad's add like vectors
    integer, intent(in)  :: a
    type(ad), intent(in) :: b
    add_i_ad = ad(a+b%x,b%dx)
  end function add_i_ad

  type(ad) function add_ad_r(a, b)
    ! ad's add like vectors
    type(ad), intent(in) :: a
    real*8, intent(in)   :: b
    add_ad_r = ad(a%x+b,a%dx)
  end function add_ad_r

  type(ad) function sub_ad_ad(a, b)
    ! ad's subtract like vectors
    type(ad), intent(in) :: a, b
    sub_ad_ad = ad(a%x-b%x,a%dx-b%dx)
  end function sub_ad_ad

  type(ad) function sub_r_ad(a, b)
    ! ad's subtract like vectors
    real*8, intent(in)   :: a
    type(ad), intent(in) :: b
    sub_r_ad = ad(a-b%x,-b%dx)
  end function sub_r_ad

  type(ad) function sub_ad_r(a, b)
    ! ad's subtract like vectors
    type(ad), intent(in) :: a
    real*8, intent(in)   :: b
    sub_ad_r = ad(a%x-b,a%dx)
  end function sub_ad_r

  type(ad) function mul_r_ad(a, b)
    !The product of ad's
    real*8, intent(in)   :: a
    type(ad), intent(in) :: b
    mul_r_ad = ad(a*b%x,a*b%dx)
  end function mul_r_ad

  type(ad) function mul_i_ad(a, b)
    !The product of ad's
    integer, intent(in)  :: a
    type(ad), intent(in) :: b
    mul_i_ad = ad(a*b%x,a*b%dx)
  end function mul_i_ad

  type(ad) function mul_ad_r(a, b)
    !The product of ad's
    type(ad), intent(in) :: a
    real*8, intent(in)   :: b
    mul_ad_r = ad(a%x*b,a%dx*b)
  end function mul_ad_r

  type(ad) function mul_ad_ad(a, b)
    !The product of ad's is given by the "product rule" of differentation:
    !   (x,dx)*(y,dy)=(xy,xdy+ydx).
    type(ad), intent(in) :: a, b
    mul_ad_ad = ad(a%x*b%x,(a%dx*b%x + a%x*b%dx))
  end function mul_ad_ad

  type(ad) function div_ad_ad(a, b)
    ! The quotient rule of differentiation gives
    !  (x,dx)/(y,dy)=(x/y,(ydx-xdy)/(y*y)).
    type(ad), intent(in) :: a, b
    div_ad_ad = ad(a%x/b%x,(a%dx*b%x - a%x*b%dx)/(b%x * b%x))
  end function div_ad_ad

  type(ad) function div_r_ad(a, b)
    !The product of ad's
    real*8, intent(in)   :: a
    type(ad), intent(in) :: b
    div_r_ad = ad(a/b%x,-a*b%dx/(b%x * b%x))
  end function div_r_ad

  type(ad) function exp_ad_int(a, n)
    type(ad), intent(in) :: a
    integer, intent(in)  :: n
    exp_ad_int = ad((a%x)**n,n*(a%x)**(n-1))
  end function exp_ad_int

  subroutine pr(str, a)
    character(len=*), intent(in) :: str
    type(ad), intent(in) :: a
    write(*,'(2(a,f14.7))') str,a%x,' ',a%dx
  end subroutine pr

end module autoDiff
