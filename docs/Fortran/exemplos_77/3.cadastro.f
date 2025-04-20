c234567      
      PROGRAM CONDITIONALS
      IMPLICIT NONE
      CHARACTER*11 NUMBER
      CHARACTER*80 INPUT_LINE  ! Large buffer for input
      CHARACTER*9 REST
      INTEGER LEN, ACTUAL_LEN

      write (*,*) 'Input Number:'
      read (*,'(A)') INPUT_LINE  ! Read entire line
      
      ! Remove any trailing spaces and get actual length
      ACTUAL_LEN = LEN_TRIM(INPUT_LINE)
      
      ! Check if input is empty
      IF (ACTUAL_LEN .EQ. 0) THEN
          write(*,*) 'No input provided'
          STOP
      END IF
      
      ! Extract up to 11 characters
      NUMBER = INPUT_LINE(1:MIN(11, ACTUAL_LEN))
      LEN = LEN_TRIM(NUMBER)
      
      IF (LEN .GT. 3) THEN
          REST = NUMBER(3:LEN)
      ELSE
          REST = ''
      END IF
      
      IF (ACTUAL_LEN .LT. 8 .OR. ACTUAL_LEN .GT. 11) THEN
          write(*,*) 'Invalid Number'
      ELSE IF (LEN .EQ. 8 .OR. LEN .EQ. 9) THEN
          write(*,*) NUMBER
      ELSE IF (LEN .EQ. 10 .OR. LEN .EQ. 11) THEN    
          write(*,*) 'DDD and number are ', NUMBER(1:2) // ' ' // REST
      END IF
      
      STOP
      END