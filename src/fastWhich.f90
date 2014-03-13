subroutine fastWhich(xCor, yCor, vecA, vecB, range, vecResult)

  implicit none

  real(kind=8) :: xCor
  real(kind=8) :: yCor
  real(kind=8), dimension(67420) :: vecA
  real(kind=8), dimension(67420) :: vecB
  real(kind=8) :: range
  logical, dimension(67420) :: vecResult
  
  integer i

  real(kind=8) :: xl 
  real(kind=8) :: xu  
  real(kind=8) :: yl  
  real(kind=8) :: yu  

  xl = xCor - range
  xu = xCor + range
  yl = yCor - range
  yu = yCor + range 

  do i = 1, 67420, 1
    if ( vecA(i) >= xl .and. vecA(i) <= xu .and. vecB(i) >= yl .and. vecB(i) <= yu) then
       vecResult(i) = .true.
    else
       vecResult(i) = .false.
    end if
  end do

end subroutine fastWhich
