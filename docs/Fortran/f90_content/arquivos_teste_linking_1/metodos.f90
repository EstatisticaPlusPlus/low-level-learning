module metodos
    use funcoes
    implicit none

contains
    subroutine novo_intervalo(inf, sup)
        real(real64), intent(inout) :: inf
        real(real64), intent(inout) :: sup
        real(real64) :: c
        real(real64) :: sinal_f_inf
        real(real64) :: sinal_f_c
        real(real64) :: novo_inf
        real(real64) :: novo_sup

        c = (inf+sup)/2
        sinal_f_inf = sign(1.0_real64, f(inf))
        sinal_f_c = sign(1.0_real64, f(c))

        if (sinal_f_inf == sinal_f_c) then
            novo_inf = c
            novo_sup = sup

        else
            novo_inf = inf
            novo_sup = c
        end if

        inf = novo_inf
        sup = novo_sup
    end subroutine novo_intervalo

    function bissecao(a, b, n_passos) result(raiz)  
        ! Limite inferior do intervalo
        real(real64), intent(in) :: a                           

        ! Limite superior do intervalo
        real(real64), intent(in) :: b 

        ! Nº máximo de passos 
        integer, intent(in) :: n_passos 

        ! Valor de x tal que f(x) = 0
        real(real64) :: raiz 

        ! Ponto médio
        real(real64) :: p_medio

        ! Variável LOCAL do limite inferior do intervalo
        real(real64) :: inf

        ! Variável LOCAL do limite superior do intervalo
        real(real64) :: sup

        ! Variável do loop
        integer :: i

        inf = a
        sup = b

        do i = 1, n_passos
            p_medio = (inf+sup)/2
            if (f(p_medio) == 0) then
                raiz = p_medio
                return

            else
                call novo_intervalo(inf, sup)
            end if
        end do

        raiz = p_medio
    end function bissecao
end module metodos
