.data
num: .space 2000

.text
li $s1, 500
li $t0, 1
sw $t0, num($0)
#read n in $s0
li $v0, 5
syscall
move $s0, $v0
li $t0, 2 #$t0 as loop integer "i"
addi $s3, $s0, 1
li $t2, 1
beq $s0, $0, min
beq $s0, $t2, min

li $s5, 0
loop:
beq $t0, $s3, loop_end #i = 2;i <= n;i++
#jinwei:$t1
#j:t2
#temp:t3
#$t4:compariosn
#$t5:arguments
li $t1, 0
li $t2, 0

while:
slt $t4, $t2, $s1
beq $t4, $0, next
move $t3, $t1

sll $t5, $t2, 2 #$t5 = $t2 * 4
move $t8, $t5 #address of a[j]
lw $t5, num($t5) #$t5 = a[j]
mult $t5, $t0
mflo $t5 #a[j] * i

li $t6, 10
add $t1, $t5, $t1
div $t1, $t6
mflo $t1 #(a[j]*i + jinwei)/10

add $t7, $t5, $t3
div $t7, $t6
mfhi $t7 #(a[j]*i + temp)%10
sw $t7, num($t8)

ble $t2, $s5, no_replace#
move $s5, $t2#
no_replace:#
#or $t9, $t1, $t7
#beqz $t9, next

addi $t2, $t2, 1
j while

next:
addi $t0, $t0, 1
j loop

loop_end:
sll $s6, $s5, 2

whi:
lw $t8, num($s6)
bne $t8, $0, bre #not 0
addi $s6, $s6, -4
j whi

bre:
blt $s6, $0, end
lw $a0, num($s6)
li $v0, 1
syscall
addi $s6, $s6, -4
j bre


end:
li $v0, 10
syscall

min:
li $a0, 1
li $v0, 1
syscall
j end
