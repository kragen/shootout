! The Great Computer Language Shootout
! http://shootout.alioth.debian.org/
!
! contributed by Simon Geard, 25/03/2005
!
! A string module to do some basic string manipulaions. Much smaller
! that the iso_varying_string module so hopefully people will be able
! to see what's going on more easily.
!
! $Id: string.f90,v 1.1 2005-03-29 07:34:50 bfulgham Exp $ ; $Name:  $
!
module string

  integer, parameter, private :: rsize = 64
  type str
     private
     ! A string type that is dynamically allocatable
     character(len=rsize), dimension(:), allocatable :: s
     integer :: nblocks  ! The number of blocks of size rsize required for the string
     integer :: nchars   ! The number of chars
  end type str

  interface assignment(=)
     module procedure assign_str_str
  end interface

contains

  subroutine assign_str_str(to, from)
    type(str), intent(out) :: to
    type(str), intent(in)  :: from
    allocate(to%s(from%nblocks))
    to%s = from%s
    to%nblocks = from%nblocks
    to%nchars = from%nchars
  end subroutine assign_str_str

  integer function numWords(rline)
    ! Count the number of words
    type(str), intent(in), target :: rline

    integer, parameter :: tab = 9
    integer, parameter :: space = 32

    integer :: i, j, ng
    logical :: ingap, started
    character(len=rsize), pointer :: line
    integer, pointer              :: bline


    ingap = .false.
    ng = 0
    started = .false.

    ! Search in the 1st block
    bline => rline%nblocks
    if (bline == 0) then
       numWords = 0
       return
    end if
    line => rline%s(1)
    do i=1,len(line)
       if (.not. started) then
          started = (line(i:i) /= ' ')

       elseif ( .not. ingap .and. (line(i:i) .eq. ' ' .or. line(i:i) .eq. achar(tab))) then
          ng = ng + 1
          ingap = .true.

       elseif (ingap .and. ischar(line(i:i))) then
          ingap = .false.

       end if
    end do
    if (bline == 1) then
       if (ingap) ng = ng - 1
       numWords = ng + 1
       return
    end if

    ! Do the next n-2 blocks
    do j=2,bline-1
       line => rline%s(j)
       do i=1,len(line)
          if (.not. started) then
             started = (line(i:i) /= ' ')

          elseif (.not. ingap .and. (line(i:i) .eq. ' ' .or. line(i:i) .eq. achar(tab))) then
             ng = ng + 1
             ingap = .true.

          elseif (ingap .and. ischar(line(i:i))) then
             ingap = .false.
          end if
       end do
    end do

    ! Do the last block
    line =>rline%s(bline)
    do i=1,len(trim(line))
       if (.not. started) then
          started = (line(i:i) /= ' ')

       elseif (.not. ingap .and. (line(i:i) .eq. ' ' .or. line(i:i) .eq. achar(tab))) then
          ng = ng + 1
          ingap = .true.

       else if (ingap .and. ischar(line(i:i))) then
          ingap = .false.
       end if
    end do
    numWords = ng + 1

  contains
    pure logical function ischar(c)
      character, intent(in) :: c
      ischar = (iachar(c) > 32 .and. iachar(c) < 127)
    end function ischar

  end function numWords

  ! Return the number of chars in the string
  pure integer function numChars(line)
    type(str), intent(in) :: line
    numChars = line%nchars
  end function numChars

  ! Diagnostic print  procedure (not used)
  subroutine print(line)
    type(str), intent(in) :: line
    integer :: i
    write(*,'(i0,a)',advance='no') line%nblocks,' '
    do i=1,line%nblocks-1
       write(*,'(a)',advance='no') line%s(i)
    end do
    write(*,'(a)',advance='yes') line%s(line%nblocks)
  end subroutine print

  ! Get a line from stdin as a str
  subroutine getLine(rline, finished)
    type(str), intent(out) :: rline      ! a str object containing the whole line
    logical, intent(out)   :: finished   ! .true. when there is no more input

    integer                :: nread
    type(str)              :: work
    character(len=rsize)   :: str_blk

    allocate(rline%s(4096/rsize)) ! Allocate 4096 chars for the line (max allowed)
    rline%nblocks = 0
    rline%nchars = 0
    readLine: do
       rline%nblocks = rline%nblocks+1
       read(5,fmt='(a)',end=100,eor=10,size=nread,advance='no') str_blk
       if (rline%nblocks > size(rline%s)) then
          call enlargeLine
       end if
       rline%s(rline%nblocks) = str_blk(1:nread)
       rline%nchars = rline%nchars + nread
    end do readLine
10  continue
    if (rline%nblocks > size(rline%s)) then
       call enlargeLine
    end if
    rline%nchars = rline%nchars + nread
    if (nread == 0) then
       rline%nblocks = rline%nblocks - 1
    else
       rline%s(rline%nblocks) = str_blk(1:nread)
    end if
    finished = .false.
    return
100 continue
    finished = .true.
    return

  contains

    subroutine enlargeLine
      ! Allocate more memory for a line if requested
      allocate(work%s(size(rline%s)))
      work = rline
      deallocate(rline%s)
      allocate(rline%s(2*size(work%s)))
      rline = work
      deallocate(work%s)
    end subroutine enlargeLine
  end subroutine getLine

end module string

