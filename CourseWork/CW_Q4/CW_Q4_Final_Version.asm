.data
prompt_for_input: .asciiz "Please enter your numbers, pressing enter after each, (0 to terminate):\n"
prompt_for_output: .asciiz "Your quantity of interest is equal to: "

.text
main:
# prompting the user with a message for a string input:
li $v0, 4
la $a0, prompt_for_input
syscall

li  $s0, 0
LOOP:
li  $v0, 5
syscall

slt $t0, $v0, 0
div $t1,$v0, 4
mul $t2, $t1, 4

bne $t2, $v0, LOOP
addu $s0, $s0, $t0
bne $v0, $zero, LOOP

# prompting the user with a message for the processed output:
li $v0, 4
la $a0, prompt_for_output
syscall

# printing the output
addiu  $v0, $zero, 1
addu $a0, $zero, $s0
syscall

# Finish the programme:
li $v0, 10      # syscall code for exit
syscall         # exit
