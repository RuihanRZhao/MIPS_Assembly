.text
    la   $a0, MSG_INPUT_PROMPT
    addi $v0, $zero, 4        # to print string
    syscall                   # Prompt to get an input

    addi $v0, $zero, 5        # to get integer
    syscall
    add  $s0, $zero, $v0      # Store the input value into s0

    addi $v0, $zero, 4        # to print string
    addi $t0, $zero, 1
    la   $a0, MSG_NEITHER     # load MSG_NEITHER
    beq  $s0, $t0,   IS_ONE   # if input equals 1, load MSG_ONE
    beq  $s0, $zero, IS_ZERO  # if input equals 0, load MSG_ZERO
    syscall                   # print MSG of 1or0 judgement
    la   $a0, MSG_Num_Stroge
    syscall                   # print "Your Input: "
    addi $v0, $zero, 1        # to print integer
    add  $a0, $zero, $s0      # print the value of Input
    syscall
    j EXIT
  IS_ZERO:
    la   $a0, MSG_ZERO
  IS_ONE:
    la   $a0, MSG_ONE
  EXIT:
    addi $v0, $zero, 10
    syscall


.data
  MSG_Num_Stroge:   .asciiz     "Your Input: "
  MSG_INPUT_PROMPT: .asciiz     "Input: "
  MSG_ZERO:         .asciiz     "\nIt was zero!"
  MSG_ONE:          .asciiz     "\nIt was one!"
  MSG_NEITHER:      .asciiz     "\nIt was neither!"
