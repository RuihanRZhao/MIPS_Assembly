.data
buffer_for_input_string: .space 100
buffer_for_processed_string: .space 100
prompt_for_input: .asciiz "Please enter your string:\n"
prompt_for_output: .asciiz "Your processed string is as follows:\n"

.text
main:
# PROMPTPING the user with a message for a string input:
li $v0, 4
la $a0, prompt_for_input
syscall

# READING the input string and putting it in the memory:
## the starting address of the string is accessible as buffer_for_input_string
## 100 is the hard-coded maximum length of the null-terminated string that is
## going to be read from the input. So effectively, up to 99 ascii characters.
li $v0, 8
la $a0, buffer_for_input_string
li $a1, 100
syscall

# >>>> MAKE YOUR CHANGES BELOW HERE:
addi    $t5,    $zero,  1

# Looping over characters of the string:
la      $t0, buffer_for_input_string
la      $t1, buffer_for_processed_string
Loop:
lb      $t2,  0($t0)

beq     $t2,    $zero,  SKIP      # if t2 == 0, go to SKIP

# If t2 is around 'A' to 'Z', go to SKIP.
li      $t3,    'A'
slt     $t4,    $t2,    $t3
li      $t3,    'Z'
slt     $t5,    $t3,    $t2
or      $t4,    $t5,    $t4
beq     $t4,    $zero,  SKIP

# If t2 is around 'a' to 'z', go to SKIP.
li      $t3,    'a'
slt     $t4,    $t2,    $t3
li      $t3,    'z'
slt     $t5,    $t3,    $t2
or      $t4,    $t5,    $t4
beq     $t4,    $zero,  SKIP

# If t2 == ' ', go to SKIP
beq     $t2,    ' ',    SKIP

# Else go to ACT
jal     ACT

ACT:
#If t2 holds a punctuation character, go to next character
addi    $t0,    $t0,    1
bne     $t2,    $zero,  Loop

SKIP:
#If t2 holds a letter or blank, record it and go to next place
sb      $t2, 0($t1)
addi    $t0, $t0, 1
addi    $t1, $t1, 1
bne     $t2, $zero, Loop # keep going until you reach the end of the string,
                         # which is demarcated by the null character.
jal    End        # jump to End and save position to $ra

End:
# <<<< MAKE YOUR CHANGES ABOVE HERE

# prompting the user with a message for the processed output:
li $v0, 4
la $a0, prompt_for_output
syscall

# printing the processed output
# note that v0 already holds 4, the syscall code for printing a string.
la $a0, buffer_for_processed_string
syscall

# Finish the programme:
li $v0, 10      # syscall code for exit
syscall         # exit
