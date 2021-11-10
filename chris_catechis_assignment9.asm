# Author: Christopher Catechis <8000945777>
# Section: 1001
# Date Last Modified: 11/9/2021
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
	li $s0, COUNT  # index
	li $t1, 0  # sum

	sumDollarLoop:
		lw $t2, ($t0)  # retrive dollarAmounts(n)
		add $t1, $t1, $t2  # sum += dollaramounts(n)
		add $t0, $t0, 4  # dollarAmounts(n++)
		sub $s0, $s0, 1  # index--
		bnez $s0, sumDollarLoop

		sw $t1, totalDollars  # save current sum to variable

	# reset some registers
	la $t0, centAmounts  # cents starting address
	li $s0, COUNT  # index
	li $t1, 0  # sum
	
	sumCentLoop:
		# loop body
		lw $t2, ($t0)  # retrive centAmounts(n)
		add $t1, $t1, $t2  # sum += centAmounts(n)
		add $t0, $t0, 4  # centAmounts(n++)
		sub $s0, $s0, 1  # index--
		bnez $s0, sumCentLoop

		sw $t1, totalCents  # save current sum to variable

	# Convert dollars to cents and add to cent total
	lw $t0, totalDollars
	lw $t1, totalCents
	li $t2, 100  # load 100 for division/addition

    mul $t0, $t0, $t2
	add $t1, $t0, $t1  # t1 += $t0

	# Calculate dollars and cents using division on the cent total

	div $t3, $t1, $t2  # answer in $t3
	rem $t4, $t1, $t2  # answer in $t4
	
	# Store results in totalDollars and totalCents
	sw $t3, totalDollars  # store t3->totalDollars
	sw $t4, totalCents # store t4->totalCents

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