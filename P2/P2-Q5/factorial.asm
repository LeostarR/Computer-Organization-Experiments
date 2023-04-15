.data
num: .space 4000

.text
li $s1, 1000
li $t0, 1
sw $t0, num($0)
#read n in $s0
li $v0, 5
syscall
move $s0, $v0

addi $s3, $s0, 1 #"n + 1"
li $t2, 1
beq $s0, $0, min
beq $s0, $t2, min

li $s5, 0
li $t4, 1
li $t0, 2 #$t0 as loop integer "i"
loop:
beq $t0, $s3, loop_end #i = 2;i <= n;i++
#jinwei:$t1
#j:t2
#temp:t3
#$t4:digit
#$t5:arguments
li $t1, 0
li $t2, 0

for_j:
beq $t2, $t4, j_end

sll $t5, $t2, 2
lw $t5, num($t5) #a[j]
mult $t5, $t0 #a[j] * i
mflo $t5
add $t5, $t1, $t5
move $t3, $t5 #temp = a[j]*i + jinwei

li $t6, 10
div $t3, $t6 # temp / 10

sll $t5, $t2, 2
mfhi $t6
sw $t6, num($t5) #a[j] = temp % 10
mflo $t6
move $t1, $t6 #jinwei = temp / 10;

addi $t2, $t2, 1
j for_j

j_end:

while:
beqz $t1, next

li $t6, 10
div $t1, $t6
sll $t5, $t2, 2

mfhi $t6
sw $t6, num($t5) #a[j] = jinwei % 10
mflo $t1 #jinwei /= 10
addi $t2, $t2, 1 #j++
j while

next:
move $t4, $t2
addi $t0, $t0, 1
j loop

loop_end:

sub $t0, $t4, 1#digit in $t0
out:
bltz $t0, end
sll $t5, $t0, 2
lw $a0, num($t5)
li $v0, 1
syscall
addi $t0, $t0, -1
j out

end:
li $v0, 10
syscall

min:
li $a0, 1
li $v0, 1
syscall
j end
