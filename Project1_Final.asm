#######################################################################
#	Program name: Sum of integers
#	Programmwr: Alexis Montes
#	Date lasr modifies:
#######################################################################
# Functional Descriptions
# A program to find the sum of the integers from 1 to N, where N is a value 
# reas in from the keyboard
#######################################################################
# Pseudocode desciption of algorithm 
# main:		cout << "\n Please input a value for N = "
#		cin >> v0
#		if ( v0 > 0 )
#			{t0 = 0;
#			while (v0 > 0 ) do
#				(t0 = t0 + v0;
#				v0 = v0 - 1)
#			cout << "	The sum of the integers from 1 to N is ", t0;
#			go to main
#			}
#		else 
#			cout << "\n **** Adios Amigo - have a good day ****"
########################################################################
# Cross Refereces:
# v0: = N,
# t0: Sum
########################################################################
	 .data
Prompt: .asciiz 	"\n Please Input a value for N =  "
Result: .asciiz 	"The sum of the integers from 1 to N is "
Bye:	.asciiz 	"\n **** Adios Amigo - Have a good day****"
	.globl 		main
	.text
	
main:
	li		$v0, 4		# System call code for print string
	la		$a0, Prompt	# load adress of prompt into $a0
	syscall 			# Print the prompt message
	
	li		$v0, 6		# System call code for Read integer, changed to 6 for float
	syscall 			# reads the value of N int $v0


mfc1  			$t1, $f0		# saves value read into $t1 (integer)

blez $t1, End				# if the saves value is less than 0 then branch to end
# bello code removes the significand from the value input saving the exponent and sign in t2
srl 			$t2, $t1, 23		# shifts bit to the right by 23 and saves in $t3

# to get the real exponent we subtract -127 to get the real value and save it to s3
# s3 = exponenet
add 			$s3, $t2, -127		# add -127 to $t2 and save into $s3

#******************************************************************

# 4) zero out exponenet result in $t6

# shifts out the exponent part leaving only the integer part in t5
sll 			$t4, $t1, 9		# moves bit left then right by 9 saving result in $t5
srl  			$t5, $t4, 9

# gets real value by adding 8388608 to it saving in t6
add 			$t6, $t5, 8388608	# adds 8388608 to value in t5 and saves in t6

#******************************************************************

# saves new value of exponent + 9 into t7
# rotates the bits in t6(real value) by value of t7 saves in t4

add 			$t7, $s3, 9		# adds 9 to $s3 ans saves in t7
rol  			$t4, $t6, $t7		# rotates bits of t6 by t7 and saves in t4

# *****************************************************************

# subtracts 31 from value in t5(integer part) saving it in t2
li			$t5, 31			# loads 31 into $t5
sub 			$t2, $t5, $s3		# subtracts value of s3 from t5 and saces in t2

# shifts in both directions by value in t2 and saves is in s3
sllv 			$t5, $t4, $t2 		# shifts t4 to left by value in t2 and saves in t5
srlv 			$s3, $t5, $t2		# shifts to the right by t2 ans daces in $s3

	
	blez 		$v0, End	# branch to end if $v0 == 0
	li 		$t0, 0		# clear regiater $t0 to 0
	
# loop runs from 1 to value in v0
# uses t0, now uses s3 instead of v0
Loop:
	add		$t0, $t0, $s3	# sum of integers in resister $t0
	addi 		$s3, $s3, -1	# summing integers in reverse order
	bnez		$s3, Loop	# branch to loop if $v0 is != 0
	
	li		$v0, 4		# System call code for print string
	la 		$a0, Result	# load adress of message into $a0
	syscall 			# print the string
	
	li		$v0, 1		# system call code for print integer
	move		$a0, $t0	# movw value to be printed to $a0
	syscall 			# print sum of integers
	b 		main		# branch to main
	
End:	li		$v0, 4
	la		$a0, Bye
	syscall 
	li		$v0, 10
	syscall 
	

