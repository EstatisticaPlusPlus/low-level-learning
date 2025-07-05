c234567
      PROGRAM SolveLinearSystem
      IMPLICIT NONE

      INTEGER :: n, nrhs, lda, ldb, info
      PARAMETER (n = 3, nrhs = 1, lda = n, ldb = n)

      REAL :: A(lda, n), B(ldb, nrhs)
      INTEGER :: ipiv(n)

      EXTERNAL SGESV
  
      DATA A / 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 10.0 /
      DATA B / 6.0, 15.0, 25.0 /

      PRINT *, 'Starting the linear system solver...'
      
      CALL SGESV(n, nrhs, A, lda, ipiv, B, ldb, info)

      PRINT *, 'SGESV call completed.'

      IF (info .EQ. 0) THEN
          PRINT *, 'The solution is:'
          PRINT *, B
      ELSE
          PRINT *, 'An error occurred: info =', info
      END IF

      PRINT *, 'Program finished.'
      
      STOP      
      END