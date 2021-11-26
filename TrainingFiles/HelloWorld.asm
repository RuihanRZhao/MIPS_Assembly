.text
  addi $v0,$zero,4
  la $a0, m
  syscall
  addi $v0, $zero, 10
  syscall
.data
  m: .asciiz "Hello World"
