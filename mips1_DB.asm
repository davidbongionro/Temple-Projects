# Advanced Processors - HW 1
# David Bongiorno
# 09/17/17
.data	# What follows will be data
prompt1: .asciiz "Enter the first number: "	 # the string " Enter the first number: " is stored in prompt1
prompt2: .asciiz "\nEnter the second number: "	 # the string " Enter the first number: " is stored in prompt2
prompt3: .asciiz "\nOperation: " 		 # the string " Operation: "		  is stored in prompt3
display: .asciiz "\nThe number you entered is: "
ans:  	 .asciiz "\nAns: "
error: 	 .asciiz "\n The operation could not be performed - division by zero is undefined. \n"
opChar:  .byte '+', '-', '*', '/'
						


.text	# What follows will be actual code
main: 	
	# Diplay initial prompt			
	la	$a0, prompt1	# Load the address of "prompt1" to $a0
	li	$v0, 4		# Load register $v0 with 4
	syscall			# print prompt1 to the I/O window
	
	# Read 1st NUM
	li	$v0, 5
	syscall
	move	$t0, $v0	# Need to move content of $v0 to another available temporary register ($t0 in this case)
	
	# Display string
	la	$a0, display	# Load the address of "display" to $a0
	li 	$v0, 4
	syscall
	
	# Display 1st NUM
	move	$a0, $t0	# move the integer to be printed to $a0
	li	$v0, 1		# Load $v0 with 1 syscallv0 to another available temporary register ($t0 in this case)	
	syscall
	
	
	
	# Display 2nd prompt			
	la	$a0, prompt2	# Load the address of "prompt2" to $a0
	li	$v0, 4		# Load register $v0 with 4
	syscall			# print prompt2 to the I/O window
	
	# Read 2nd NUM
	li	$v0, 5
	syscall
	move	$t1, $v0	# Need to move content of $v0 to another available temporary register ($t1 in this case)
	
	# Display string
	la	$a0, display	# Load the address of "display" to $a0
	li 	$v0, 4
	syscall
	
	# Display 2nd NUM
	move	$a0, $t1	# move the integer to be printed to $a0
	li	$v0, 1		# Load $v0 with 1 syscallv0 to another available temporary register ($t1 in this case)
	syscall
	
Operation:		
	# Display Operational prompt			
	la	$a0, prompt3	# Load the address of "prompt3" to $a0
	li	$v0, 4		# Load register $v0 with 4
	syscall			# print prompt3 to the I/O window
	
	# Read operational char	
	li	$v0, 12		
	syscall
	
	move	$t3, $v0   # Need to move content of $v0 to another available temporary register ($t3 in this case)
	la $t4, opChar	   #load array of operational characters into $t4 for comparison & branching 
	
	#display ans string
	la 	$a0, ans
	li	$v0, 4
	syscall	
			
	#Compare operational character to each array to determine branch path				
	lb $t5, 0($t4)
	beq $t3, $t5, Addition
	
	lb $t5, 1($t4)
	beq $t3, $t5, Subtraction
	
	lb $t5, 2($t4)
	beq $t3, $t5, Multiplication
	
	lb $t5, 3($t4)
	beq $t3, $t5, Division
	
	j Operation
		
Addition:
	add  $t6, $t0, $t1

	#display numerical ans
	move, $a0, $t6
	li $v0, 1
	syscall
	
	j Operation
	
Subtraction:
	sub  $t6, $t0, $t1
	
	#display numerical ans
	move 	$a0, $t6
	li	$v0, 1
	syscall 
	j Operation
	
Multiplication:
	mul  $t6, $t0, $t1
	
	#display numerical ans
	move 	$a0, $t6
	li	$v0, 1
	syscall 

	j Operation	
Division:
	beqz $t1, Undefined
	div $t6, $t0, $t1
	
	#display numerical ans
	move 	$a0, $t6
	li	$v0, 1
	syscall
	j Operation
	
Undefined: 	
	# Diplay error prompt			
	la	$a0, error	# Load the address of "error" to $a0
	li	$v0, 4		# Load register $v0 with 4
	syscall
	j main