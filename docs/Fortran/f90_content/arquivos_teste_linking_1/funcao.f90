module funcoes
    use, intrinsic :: iso_fortran_env
    implicit none

contains
    function f(x) result(y)
        real(real64), intent(in) :: x
        real(real64) :: y

        y = x**3 - x - 2
    end function f
end module funcoes
