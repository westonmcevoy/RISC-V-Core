

 // Section .crt0 is always placed from address 0
	.section .crt0, "ax"

_start:
	.global _start

 /*
 	Assembly Abstraction assignment
 	Note:
 	  - As a minimum, you should plan to allocate registers for the following to
 	    to implement the routine

 	    - maximum count of loop which will be initialized to your first initial, lowercase
	         - you can tell the assembler to evaluate your initial by specifying a 
		 character
		 - example:  addi  x10, x0, 'k'
 	    - count variable, i, that will go from 0 to maximum count
 	    	- or, the count variable could be assigned max value and count to 0
 	    - result variable which is initialized to 0
 	    - memory address to store result initialized to 0x2000


 	    hint:  you can use the RISCV add immediate instruction, addi, to initialize
 	        a register

 	Start here
 */

// Plan (Declare) by making a comment for each register that you will be using and its purpose
// These comments will be helpful to refer back to determine which register to use 
# lui x1, 0x2000
# srli x1, x1, 12

// This took thirty minutes of writing, compiling, and debugging before it was working perfectly (moderate)
// To convert this to machine code took 20 minutes with the shortcut (moderate)
// If I had to debug machine code it would take hours (very very difficult)
lui x4, 0x2000          // Memory location to store - 0x02000237
srli x4, x4, 12         // Shifting over to LSBs    - 0x00c25213
addi x1, x0, 'M'        // letter                   - 0x06b00093
addi x2, x0, 0          // result                   - 0x00000113
addi x3, x0, 0          // i                        - 0x00000193
loop:                
    add x2, x2, x3      // result + i               - 0x00310133
    add x2, x2, x1      // result + letter          - 0x00110133
    addi x3, x3, 1      // i++                      - 0x00118193
    bne x3, x1, loop    // if i < letter then loop  - 0xfe119ae3
sw x1, 0(x4)            // store letter             - 0x00122023
sw x2, 4(x4)            // store result             - 0x00222223
sw x3, 8(x4)            // store i                  - 0x00322423





// Initialize all of your registers.  Immediate instructions are recommended where possible



// Implement your for loop



// Store into memory the result(s)



 /*
 	Add your assembly code above this line
 */
	nop
	nop
	nop
	halt	// end of simulation result = 0x00002297 or 8855
	nop
	nop
	nop
