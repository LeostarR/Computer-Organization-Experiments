.data
array: .space 80

.macro get_add(%ans, %i)
	sll %ans, %i, 2
.end_macro


.text
li $v0, 5
syscall 
move $s0, $v0 #read n in $s0

li $t0, 0
loop:
beq $t0, $s0, loop_end

li $v0, 12
syscall
get_add($t1, $t0)
sw $v0, array($t1) #store in array
addi $t0, $t0, 1
j loop
loop_end:


li $t0, 0
li $t1, 2
div $s0, $t1
mflo $t1

tes_loop:
beq $t0, $t1, tes_end
get_add($t5, $t0)
lw $t2, array($t5)
addi $t6, $s0, -1
sub $t6, $t6, $t0
get_add($t4, $t6)
lw $t3, array($t4)

bne $t2, $t3, endnot
addi $t0, $t0, 1
j tes_loop
tes_end:#yes

li $a0, 1
li $v0, 1
syscall
j end

endnot:#no
li $a0, 0
li $v0, 1
syscall

end:
li $v0, 10
syscall


