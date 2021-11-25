# All program code is placed after the
# .text assembler directive

.text
  la $t0,MY_INT_ARRAY
  lw $t1, 4($t0)
  add $t1,$t1,$t1
  sw $t1, 4($t0)


  addi $v0, $zero, 10     # Sets $v0 to "10" to select exit syscall
  syscall                 # Exit

  # All memory structures are placed after the
  # .data assembler directive

.data
  MY_MSG: .asciiz "QMUL!"
  MY_INT_ARRAY:
      .word   -2
      .word   2
      .word   2021
  MY_INT_ARRAY_LEN:   .word   3
