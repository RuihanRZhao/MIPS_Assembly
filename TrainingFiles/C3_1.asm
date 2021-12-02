.text
    la  $s0, MY_INT_ARRAY_LEN
    lw  $s0, 0($s0)             # s0: MY_INT_ARRAY_LEN
    addi  $t0, $zero, 0         # t0: to hold the "index" of the next array entry
    la  $t1, MY_INT_ARRAY       # t1: to hold the "address" of the next array entry initialised to the address of the first byte of the array

    slt $t3, $zero, $s0             # t3 gets whether 0 is less that s0, t3 will be 0 if s0 is less than or equal to 0
    beq $t3, $zero, DONE_PRINTING   # goto DONE_PRINTING if s0 less than or equal to 0

    NEXT_ARRAY_PRINT:
    addi $v0, $zero, 1              # set v0 to invoke "print integer" syscall
    lw $a0,0($t1)                   # a0 gets the integer to be printed
    syscall                         # invoking the syscall to print the integer

    addi $t0,$t0,1                  # incrementing t0 (the array index) by ?
    beq $t0, $s0, DONE_PRINTING     # jump to DONE_PRINTING when reached array's end

    addi  $v0, $zero, 4             # set v0 to invoke "print string" syscall
    la $a0, MSG_SPACER              # a0 gets the the address of the string's starting byte
    syscall                         # invoking the syscall to print the string

    addi $t1,$t1,4                  # incrementing t1 by ?

    j NEXT_ARRAY_PRINT              # jump to NEXT_ARRAY_PRINT (our for loop)

    DONE_PRINTING:
    addi $v0, $zero, 10             # set v0 to "10" to select exit syscall
    syscall                         # invoking the syscall to actually exit!s

    # All memory structures are placed after the .data assembler directive
.data
    MSG_SPACER:  .asciiz ", "       # the comma (and space) string
    MY_INT_ARRAY:                   # our integer array
        .word    1
        .word   -4
        .word    5
        .word    0
        .word    2
        .word   -5
        .word   -3
    MY_INT_ARRAY_LEN:   .word   7   # the length of the array
