.data
matrix1: .space 400
matrix2: .space 400
matrix3: .space 400
str_space: .asciiz " "
str_enter: .asciiz "\n"

.macro get_add(%add, %i, %j, %ans)
	mult %add, %i
	mflo %ans
	add %ans, %ans, %j
	sll %ans, %ans, 2
.end_macro

.text
li $v0, 5
syscall
move $s0, $v0 #read m1

li $v0, 5
syscall
move $s1, $v0 #read n1

li $v0, 5
syscall
move $s2, $v0 #read m2

li $v0, 5
syscall
move $s3, $v0 #read n2

#read matrix1 $t0 as i, $t1 as j
li $t0, 0

read_1i:
beq $t0, $s0, endi1
li $t1, 0

read_1j:
beq $t1, $s1, endj1
li $t3, 10
get_add($t3, $t0, $t1, $t2)#$t2 as offset
li $v0, 5
syscall
sw $v0, matrix1($t2)
addi $t1, $t1, 1
j read_1j

endj1:
addi $t0, $t0, 1
j read_1i
endi1: #1 read end

#read matrix2
li $t0, 0

read_2i:
beq $t0, $s2, endi2
li $t1, 0

read_2j:
beq $t1, $s3, endj2
li $t3, 10
get_add($t3, $t0, $t1, $t2)#$t2 as offset
li $v0, 5
syscall
sw $v0, matrix2($t2)
addi $t1, $t1, 1
j read_2j

endj2:
addi $t0, $t0, 1
j read_2i
endi2: #2 read end

cal:
sub $s4, $s0, $s2
sub $s5, $s1, $s3
addi $s4, $s4, 1
addi $s5, $s5, 1
li $t0, 0
#$s4 as new m, $s5 as new n
#s0 - #s5 has been used
i_begin:
beq $t0, $s4, i_end
li $t1, 0

j_begin:
beq $t1, $s5, j_end

li $t9, 0
li $t5, 0
#$t5 as new i, $t6 as new j
m_begin:
beq $t5, $s2, m_end

li $t6, 0
n_begin:
beq $t6, $s3, n_end

li $t3, 10
get_add($t3, $t5, $t6, $t2) #t2 as offset
lw $s6, matrix2($t2)
add $t7, $t0, $t5
add $t8, $t1, $t6
li $t3, 10
get_add($t3, $t7, $t8, $t2)
lw $s7, matrix1($t2)
mult $s6, $s7
mflo $s7
add $t9, $t9, $s7#add $t8... $t8 has been used (err)

addi $t6, $t6, 1
j n_begin
n_end:
addi $t5, $t5, 1
j m_begin

m_end:
li $t3, 10
get_add($t3, $t0, $t1, $t2)
sw $t9, matrix3($t2)

addi $t1, $t1, 1
j j_begin

j_end:
addi $t0, $t0, 1
j i_begin
i_end:

#out
li $t0, 0
p1_begin:
beq $t0, $s4, p1_end
li $t1, 0

p2_begin:
beq $t1, $s5, p2_end
li $t3, 10
get_add($t3, $t0, $t1, $t2)
lw $a0, matrix3($t2)
li $v0, 1
syscall
la $a0, str_space
li $v0, 4
syscall
addi $t1, $t1, 1
j p2_begin

p2_end:
la $a0, str_enter
li $v0, 4
syscall

addi $t0, $t0, 1
j p1_begin
p1_end:

li $v0, 10
syscall

