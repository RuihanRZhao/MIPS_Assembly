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
addi    $t6,    $zero,  0     # t6: if start with Capital letter
addi    $t7,    $zero,  0     # t6: if the letter is first of a word (0: yes, other: no)
# Looping over characters of the string:
la      $t0, buffer_for_input_string
la      $t1, buffer_for_processed_string
Loop:
lb      $t2,    0($t0)
beq     $t2,    $zero,  End      # if t2 == 0, go to End

# Where the letter is
bne     $t7,    0,  Body
jal     Head

Head:
# If t2 is around 'a' to 'z', go to Illegal.
li      $t3,    'a'
slt     $t4,    $t2,    $t3
li      $t3,    'z'
slt     $t5,    $t3,    $t2
or      $t4,    $t5,    $t4
beq     $t4,    $zero,  H_Illegal

# If t2 is around 'A' to 'Z', go to Legal.
li      $t3,    'A'
slt     $t4,    $t2,    $t3
li      $t3,    'Z'
slt     $t5,    $t3,    $t2
or      $t4,    $t5,    $t4
beq     $t4,    $zero,  H_Legal

# If t2 is other character, go to Legal
li      $t3,    '.'
beq     $t2,    $t3,  H_Legal
li      $t3,    ','
beq     $t2,    $t3,  H_Legal
li      $t3,    '!'
beq     $t2,    $t3,  H_Legal
li      $t3,    '?'
beq     $t2,    $t3,  H_Legal
li      $t3,    ';'
beq     $t2,    $t3,  H_Legal
li      $t3,    ':'
beq     $t2,    $t3,  H_Legal

# If t2 is a number, go to Legal
li      $t3,    '0'
slt     $t4,    $t2,    $t3
li      $t3,    '9'
slt     $t5,    $t3,    $t2
or      $t4,    $t5,    $t4
beq     $t4,    $zero,  H_Legal

# If t2 is a blank
addi    $t6,    $zero,  0
addi    $t7,    $t7,    0

sb      $t2,    0($t1)
addi    $t0,    $t0,    1
addi    $t1,    $t1,    1
jal     Loop


Body:
# If t2 is other character, go to Legal
li      $t3,    '.'
beq     $t2,    $t3,  B_Punctuation
li      $t3,    ','
beq     $t2,    $t3,  B_Punctuation
li      $t3,    '!'
beq     $t2,    $t3,  B_Punctuation
li      $t3,    '?'
beq     $t2,    $t3,  B_Punctuation
li      $t3,    ';'
beq     $t2,    $t3,  B_Punctuation
li      $t3,    ':'
beq     $t2,    $t3,  B_Punctuation

beq     $t6,     0,  B_Illegal
jal    B_Legal


B_Punctuation:
addi    $t7,    $zero,    0
# stroge the value and move cursor to next palce
sb      $t2,    0($t1)
addi    $t0,    $t0,    1
addi    $t1,    $t1,    1
jal     Loop


B_Illegal:
addi    $t7,    $t7,    1
addi    $t0,    $t0,    1
# If t2 != ' ', check next
bne     $t2,    ' ',    Loop
# If t2 == ' ', change t7 to start next word
addi    $t7, $zero, 0
jal     Loop


B_Legal:
addi    $t7,    $t7,    1
# stroge the value and move cursor to next palce
sb      $t2,    0($t1)
addi    $t0,    $t0,    1
addi    $t1,    $t1,    1
# If t2 != ' ', check next
bne     $t2,    ' ',    Loop
# If t2 == ' ', change t7 to start next word
addi    $t7, $zero, 0
jal     Loop



# if legal, stroge the letter and go to next place
H_Legal:
addi    $t6,    $zero,  1
addi    $t7,    $t7,    1

sb      $t2,    0($t1)
addi    $t0,    $t0,    1
addi    $t1,    $t1,    1
jal     Loop

# if illegal, skip till blank
H_Illegal:
addi    $t6,    $zero,  0
addi    $t7,    $t7,    1
addi    $t0, $t0, 1
jal     Loop

# Finish the function
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
