addiu   $s0, $zero, -1 # s0 = -1
addiu   $s1, $zero, -2 # s1 = -2
addiu   $s2, $zero, 3  # s2 = +3
addiu   $s3, $zero, -3 # s3 = -3
addu    $t0, $s0, $s2  # t0 = -1 +  3
addu    $t1, $s1, $s3  # t1 = -2 + -3
addu    $t2, $s1, $s2  # t2 = -2 +  3
addu    $t3, $s0, $s3  # t3 = -1 + -3
addu    $t4, $s2, $s2  # t4 =  3 +  3
addu    $t5, $s3, $s3  # t5 = -3 + -3

addiu $v0, $zero, 10 # to Exit the program
syscall # Exit
