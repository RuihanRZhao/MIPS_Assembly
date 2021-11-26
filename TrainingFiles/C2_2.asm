.text
  addi $v0, $zero, 4
  la $a0, MSG_INPUT
  syscall                 # Print MSG_INPUT
  addi $v0, $zero, 5
  syscall
  add $t0, $zero, $v0     # Get integer number
  addi $v0, $zero, 4
  la $a0, MSG_OUTPUT      # Print MSG_OUTPUT
  syscall
  addi $v0, $zero, 1
  add $a0, $zero, $t0
  syscall                 #Print the integer number Got from IO
  addi $v0, $zero, 10     # Sets $v0 to "10" to select exit syscall
  syscall                 # Exit

  # All memory structures are placed after the
  # .data assembler directive

.data
  # two (null terminated) strings:
    MSG_INPUT:  .asciiz "\nPlease enter an integer number: "
    MSG_OUTPUT: .asciiz "\nThe number you entered was: "
