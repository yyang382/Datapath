!============================================================
! CS-2200 Homework 1
!
! Please do not change main's functionality, 
! except to change the argument for factorial or to meet your 
! calling convention
!============================================================

main:       la $sp, stack		        ! load address of stack label into $sp
            lw $sp,0x0($sp)                        ! FIXME: load desired value of the stack 
                                        ! (defined at the label below) into $sp
            la $at, factorial	        ! load address of factorial label into $at
            addi $a0, $zero, 5	        ! $a0 = 5, the number to factorialize
            jalr $at, $ra		        ! jump to factorial, set $ra to return addr
            
            halt			            ! when we return, just halt
stack:	    .word 0x4000		! the stack begins here (for example, that is)
factorial:  addi $sp,$sp,-4             ! allocate space for parameter,return value
                                        ! return address, old frame pointer                    
            sw $a0, 0x3($sp)            ! save parameter
            sw $ra, 0x1($sp)            ! save return address
            sw $fp, 0x0($sp)            ! save old frame pointer
            addi $s0, $a0, 0            ! save local variable
            addi $sp, $sp,-1
            sw $s0, 0x0($sp)
            addi $fp, $sp, 0            ! fp := sp
            
            beq $zero, $a0, base        ! check for n == 0
            addi $a0,$a0, -1            ! n = n -1
            la $at, factorial           ! load address of factorial to ta
            jalr $at, $ra               ! jump to factorial
            
            lw $t0, 0x0($sp)            ! load return value to t0
            
            addi $v0, $zero, 0          ! return value = 0            
mult:       add $v0, $v0, $t0           ! v0 += t0
            addi $s0, $s0, -1
            beq $s0, $zero, end
            beq $s0, $s0, mult
            
            
base:       addi $v0, $zero, 1          ! return value = 1
end:        sw $v0, 0x3($fp)            ! store return vale
            lw $ra, 0x2($fp)            ! restore return address 
            
            addi $sp, $fp, 3            ! move sp to return value
         
            lw $fp, 0x1($fp)            ! restore old frame pointer
            lw $s0, 0x0($fp)            ! restore s0
            jalr $ra, $t0               ! return 
            


