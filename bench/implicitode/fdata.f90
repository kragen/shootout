module function_params

  ! Define a container for any function data that may be needed
  type fdata
     real*8 :: a, b, c                      ! Some data
     type(fdata), pointer :: next => null() ! Next lot of data
  end type fdata

end module function_params
