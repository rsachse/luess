subroutine fastWhich(xCor, yCor, vecA, vecB, rectRange, vecResult)
  implicit none
  real(kind=8) :: xCor
  real(kind=8) :: yCor
  real(kind=8), dimension(67420) :: vecA
  real(kind=8), dimension(67420) :: vecB
  real(kind=8) :: rectRange
  logical, dimension(67420) :: vecResult
  integer :: i
  real(kind=8) :: xl 
  real(kind=8) :: xu  
  real(kind=8) :: yl  
  real(kind=8) :: yu  
  xl = xCor - rectRange
  xu = xCor + rectRange
  yl = yCor - rectRange
  yu = yCor + rectRange 
  do i = 1, 67420, 1
    if ( vecA(i) >= xl .and. vecA(i) <= xu .and. vecB(i) >= yl .and. vecB(i) <= yu) then
       vecResult(i) = .true.
    else
       vecResult(i) = .false.
    end if
  end do
end subroutine fastWhich
