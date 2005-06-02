module function_params
  integer, parameter :: QREAL = selected_real_kind(20,4)

  ! Define a container for any function data that may be needed
  type fdata
     real(kind=qreal) :: a, b, c                      ! Some data
     type(fdata), pointer :: next => null() ! Next lot of data
  end type fdata

end module function_params
