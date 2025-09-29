program main
    use funcoes
    use metodos
    use, intrinsic :: iso_fortran_env
    implicit none

    real(real64) :: resultado
    real(real64) :: a = 1
    real(real64) :: b = 2
    integer :: n_passos = 20

    resultado = bissecao(a, b, n_passos)
    print *, resultado
end program main
