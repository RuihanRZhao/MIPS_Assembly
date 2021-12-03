.text
    la  $s0, S0
    lw  $s0, 0($s0)
    la  $s1, S1
    lw  $s1, 0($s1)
    la  $s2, S2
    lw  $s2, 0($s2)

    slt $t0, $s1, $s0
    beq $t0, $zero, SKIP


    PRINT_CHECKED:
    addi  $v0, $zero, 4
    la $a0, MSG_CHECKED
    syscall

    SKIP:
    addi $v0, $zero, 10
    syscall

.data
    MSG_CHECKED:  .asciiz "Checked!"
    # some values are put here, vary them to make sure you are getting the expected result!
    S0: .word   6
    S1: .word   7
    S2: .word   8
