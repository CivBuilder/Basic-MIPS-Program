# Author: Christopher Catechis <8000945777>
# Section: 1001
# Date Last Modified: 11/5/2021
# Program Description: Creates a simple MIPS program that will utilize arrays
# and arithmetic operations.

.data
dollarAmounts: .word 243, 123, 113, 203, 231, 147, 113, 207, 198, 160
			  .word 177, 227, 121, 197, 208, 119, 135, 134, 230, 171
			  .word 201, 101, 200, 196, 189, 240, 201, 134, 182, 201

centAmounts: .word 27, 46, 19, 81, 20, 36, 48, 61, 86, 89
			.word 89, 47, 45, 62, 64, 34, 18, 78, 84, 10
			.word 29, 11, 22, 97, 70, 61, 2, 71, 44, 92

COUNT = 30

#	Calculate these values
totalDollars: .space 4
totalCents: .space 4
	
#	Labels
amountLabel: .asciiz "Total: $"
period: .asciiz "."

#	System Services
SYSTEM_EXIT = 10
SYSTEM_PRINT_INTEGER = 1
SYSTEM_PRINT_STRING = 4	

.text
.globl main
.ent main
main:

	# Add together dollar and cent values from the provided arrays
	la $t0, dollarAmounts  # dollars starting address
	la $t1, centAmounts  # cents starting address
	lw $t2, COUNT  # index
	li $t3, 0  # sum

	sumDollarLoop:
		lw $t4, ($t0)  # retrive dollarAmounts(n)
		add $t3, $t3, $t4  # sum + dollaramounts(n)
		addu $t0, $t0, 4  # dollarAmounts(n++)
		sub $t2, $t2, 1  # index--
		bnez $t2, sumDollarLoop

		sw $t3, totalDollars  # save current sum to variable
	
	sumCentLoop:
		# reset some registers
		lw $t2, COUNT  # index
		li $t3, 0  # sum

		# loop body
		lw $t4, ($t1)  # retrive centAmounts(n)
		add $t3, $t3, $t4  # sum + centAmounts(n)
		addu $t1, $t1, 4  # centAmounts(n++)
		sub $t2, $t2, 1  # index--
		bnez $t2, sumCentLoop

		sw $t3, totalCents  # save current sum to variable



	# Convert dollars to cents and add to cent total
	# Calculate dollars and cents using division on the cent total
	# Store results in totalDollars and totalCents

	# Print Total Amount
	li $v0, SYSTEM_PRINT_STRING
	la $a0, amountLabel
	syscall
	
	li $v0, SYSTEM_PRINT_INTEGER
	lw $a0, totalDollars
	syscall
	
	li $v0, SYSTEM_PRINT_STRING
	la $a0, period
	syscall
	
	li $v0, SYSTEM_PRINT_INTEGER
	lw $a0, totalCents
	syscall

	li $v0, SYSTEM_EXIT
	syscall
.end main