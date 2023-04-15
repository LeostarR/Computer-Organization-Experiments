.data
matrix1: .space 256
matrix2: .space 256
result: .space 256
str_space:  .asciiz " "
str_enter: .asciiz "\n"

.macro get_add(%ans, %i, %j, %add)
	mult %i, %ans
	mflo %add
	add %add, %add, %j
	sll %add, %add, 2
.end_macro

.macro get_co(%ans, %i, %j, %add)
	mult %j, %ans
	mflo %add
	add %add, %add, %i
	sll %add, %add, 2
.end_macro

.text 
li $v0, 5
syscall
move $s0, $v0 #read n in $s0


#read matrix1
li $t0, 0 #row
i1_loop:
beq $t0, $s0, i1_end
li $t1, 0 #column

j1_loop:
beq $t1, $s0, j1_end
li $v0, 5
syscall #read a number in $v0
get_add($s0, $t0, $t1, $s1) #offset in $s1
sw $v0, matrix1($s1)
addi $t1, $t1, 1
j j1_loop

j1_end:
addi $t0, $t0, 1
j i1_loop
i1_end:

#read matrix2
li $t0, 0 #row
i2_loop:
beq $t0, $s0, i2_end
li $t1, 0 #column

j2_loop:
beq $t1, $s0, j2_end
li $v0, 5
syscall #read a number in $v0
get_add($s0, $t0, $t1, $s1) #offset in $s1
sw $v0, matrix2($s1)
addi $t1, $t1, 1
j j2_loop

j2_end:
addi $t0, $t0, 1
j i2_loop
i2_end:

#calculate
li $t5, 0
li $t0, 0 #row
cal_i:
beq $t0, $s0, cal_iend
li $t1, 0 #column

cal_j:
beq $t1, $s0, cal_jend
li $t6, 0
li $t5, 0

cal_k:
beq $t6, $s0, cal_kend
get_add($s0, $t0, $t6, $s1)
lw $t2, matrix1($s1) #aik
get_add($s0, $t6, $t1, $s1) #bkj
lw $t3, matrix2($s1)
mult $t2, $t3
mflo $t4 #aik*bkj
add $t5, $t4, $t5 #ai1*b1j + ai2*b2j+...
addi $t6, $t6, 1
j cal_k

cal_kend:
get_add($s0, $t0, $t1, $s1)
sw $t5, result($s1)
addi $t1, $t1, 1
j cal_j

cal_jend:
addi $t0, $t0, 1
j cal_i
cal_iend:

out:
li $t0, 0
i_beg:
beq $t0, $s0, i_end
li $t1, 0

j_beg:
beq $t1, $s0, j_end
get_add($s0, $t0, $t1, $s1)
lw $a0, result($s1)
li $v0, 1
syscall
la $a0, str_space
li $v0, 4
syscall
addi $t1, $t1, 1
j j_beg

j_end:
addi $t0, $t0, 1
la $a0, str_enter
li $v0, 4
syscall
j i_beg
i_end:

li $v0, 10
syscall


