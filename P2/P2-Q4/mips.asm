.data
array: .space 28
symbol: .space 28
str_space: .asciiz " "
str_enter: .asciiz "\n"

.macro get_add(%ans, %i)
	sll %ans, %i, 2
.end_macro

.macro push(%src)
    sw      %src, 0($sp)
    addi    $sp, $sp, -4
.end_macro

.macro pop(%des)
    addi    $sp, $sp, 4
    lw      %des, 0($sp) 
.end_macro
	

.text
#scanf n in $s0
li $v0, 5
syscall
move $s0, $v0

#canshu
li $s1, 0
move $a1, $s1

jal full_array
li $v0, 10
syscall

full_array:
#push
push($ra)
push($t0)
push($t1)
push($t2)
push($t3)
push($t4)
push($t5)
push($t6)
push($t7)

#chuandi canshu
#index in $t0
move $t0, $a1
#if (index - n ) < 0, jump
sub $t1, $t0, $s0
li $t2, 0
bltz $t1, loop_2

#if(index >= n)
loop_1:
beq $t2, $s0, loop1_end
#print "array[i]"
get_add($t3, $t2)
lw $a0, array($t3)
li $v0, 1
syscall
#print " "
la $a0, str_space
li $v0, 4
syscall
addi $t2, $t2, 1
j loop_1
loop1_end:

#print "\n"
la $a0, str_enter
li $v0, 4
syscall
#pop
pop($t7)
pop($t6)
pop($t5)
pop($t4)
pop($t3)
pop($t2)
pop($t1)
pop($t0)
pop($ra)
jr $ra

#$t2 is i
loop_2:
beq $t2, $s0, loop2_end

get_add($t3, $t2)
lw $t4, symbol($t3)
#if(symbol[i] == 0)
bne $t4, $0, next_loop

#array[index] = i + 1
get_add($t5, $t0)
addi $t6, $t2, 1
sw $t6, array($t5)

#symbol[i] = 1
li $t6, 1
sw $t6, symbol($t3)

#full_array[index + 1]
addi $t7, $t0, 1
move $a1, $t7
jal full_array

#symbol[i] = 0
li $t6, 0
sw $t6, symbol($t3)


next_loop:
addi $t2, $t2, 1
j loop_2
loop2_end:
pop($t7)
pop($t6)
pop($t5)
pop($t4)
pop($t3)
pop($t2)
pop($t1)
pop($t0)
pop($ra)
jr $ra

