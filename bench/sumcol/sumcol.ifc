! Sum access function implementation
! Simon Geard, 6/12/04
!
! Building info.
! ==============
!
! Linux  - using the Intel Fortran90 compiler:
!
!          ifort sum.f90 -O3 -static-libcxa -o sum
!
! WinXP  - Compaq Visual Fortran 6.6c
!
!          f90 sum.f90 /link /libpath:"d:\Program Files\Microsoft Visual Studio\df98\lib"
!
! Cygwin - g95 compiler
!
!          g95 sum.f90 -O3 -o sum.exe
!
program sum
  implicit none
  integer :: datum, s
  s = 0
  do
     read(5,*,end=10) datum
     s = s + datum
  end do
10 continue
  write(*,'(i0)') s
end program sum
