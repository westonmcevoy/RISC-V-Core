/*
 * regression_.s
 *
 * Author: Wes McEvoy
 * Date: 02/10/23
 *
 */

 // Section .crt0 is always placed from address 0
	.section .crt0, "ax"

_start:
	.global _start

 /*
 	Immediate (i-type) ALU operations
    
    Suggested tests or unique features of ITYPE instructions
    - there are 6 immediate arithematic operations
        - addi
        - slti
        - sltiu
        - xori
        - ori
        - andi
    - immediates are positive and negative
    - there are operations that use unsigned numbers
    - there are comparison operations that need to test the 3 options
         - less than
         - equal
         - greater than
    - there must be 3 nops between instructions in that this test will be
    used before data hazard detection and forwarding has been implemented

    Will use this test for Assignment 5: Data Path and Instruction Decode
 */
 	addi x2, x0, 2				// load 2 into register x2
 	nop
 	nop
 	nop
 	addi x2, x2, (-1 & 0xfff)	// add -1 to x2, x2 = 1
 	nop					// x2 = 2
 	nop
 	nop
 	slti x3, x2, 2				// compare 1 to 2, less than so x3 = 1
 	nop					// x2 = 1
 	nop
 	nop
 	slti x3, x2, 1				// compare 1 to 1, not less than, so x3 = 0
 	nop					// x3 = 1
 	nop
 	nop
    slti x3, x2, 0xffff         // compare 1 to -1, not less than, so x3 = 0
    nop                 // x3 = 0
    nop
    nop
 	sltiu x3, x2, 1             // compare 1 to 1, not less than, so x3 = 0
 	nop					// x3 = 0
 	nop
 	nop
 	sltiu x3, x2, 0xffff        // compare 1 to 0xffff, less than, so x3 = 1
 	nop                 // x3 = 0
 	nop
 	nop
 	sltiu x3, x2, 0             // compare 1 to 0, not less than, so x3 = 0
 	nop                 // x3 = 1
    nop
    nop
    xori x3, x2, -2             // xor 1 and -2, x3 = -1             
    nop                 // x3 = 0
    nop
    nop
    xori x2, x3, 0xffff         // xor -1 and -1, x2 = 0
    nop                 // x3 = -1
    nop
    nop
    xori x3, x2, 1              // xor 0 and 1, x3 = 1
    nop                 // x2 = 0
    nop
    nop
    ori x3, x2, 1               // 0 or 1, x3 = 1
    nop                 // x3 = 1
    nop
    nop
    ori x2, x3, -1              // 1 or -1, x2 = -1
    nop                 // x3 = 1
    nop
    nop
    ori x3, x2, 0xffff          // -1 or -1, x3 = -1
    nop                 // x2 = -1
    nop
    nop
    andi x3, x2, -1             // -1 and -1, x3 = -1  PROBLEM HERE: Evaluated to 0
    nop                 // x3 = -1   
    nop
    nop
    andi x2, x3, 1              // -1 and 1, x2 = 1    
    nop                 // x3 = -1
    nop
    nop
    andi x3, x2, 1              // 1 and 1, x3 = 1 
    nop                 // x2 = 1
    nop
    nop
    nop
    halt              // x3 = 1
    nop
    nop
    nop
    nop
 /*
 	RTYPE ALU operations

    Suggested tests or unique features of RTYPE instructions
    - there are 10 rtype arithematic operations
        - add
        - sub
        - sll
        - slt
        - sltu
        - xor
        - srl
        - sra
        - or
        - and
    - two register operands that can either be positive and negative
    - there are operations that use unsigned numbers
    - there are comparison operations that need to test the 3 options
         - less than
         - equal
         - greater than
    - there must be 3 nops between instructions in that this test will be
    used before data hazard detection and forwarding has been implemented
    
    - recommend that before testing the operations, use addi opertion to load
    different test values in registers that will be used by the different
    RTYPE instruction tests
         - example, addi x1, x0, 1   // loads a 1 in register x1
                    addi x2, x0, -1  // loads a -1 (0xffffffff) into register x2

    Will use this test for Assignment 5: Data Path and Instruction Decode
 */
    ori x5, x0, -1              // 0 or -1, x5 = -1
    nop
    nop
    nop
    add x4, x3, x2              // 1 + 1, x4 = 2
    nop                 // x5 = -1
	nop
	nop
    add x4, x4, x2              // 2 + 1, x4 = 3
	nop                 // x4 = 2
	nop
    nop
    add x4, x3, x5              // 1 + -1, x4 = 0
 	nop                 // x4 = 3
    nop
 	nop
    sub x4, x3, x5              // 1 - (-1), x4 = 2
 	nop                 // x4 = 0
    nop
    nop
    sub x4, x4, x3              // 2 - 1, x4 = 1
    nop                 // x4 = 2
    nop
    nop
    sub x4, x5, x3              // -1 - 1, x4 = -2
    nop                 // x4 = 1
    nop
    nop
    sub x4, x3, x2              // 1 - 1, x4 = 0
    nop                 // x4 = -2
    nop
    nop
    sll x4, x3, x2              // 1 << 1, x4 = 2
    nop                 // x4 = 0
    nop
 	nop
    sll x4, x3, x0              // 1 << 0, x4 = 1
    nop                 // x4 = 2
    nop
    nop
    sll x4, x5, x2              // -1 << 1, x4 = -2
    nop                 // x4 = 1
    nop
    nop
    sll x4, x0, x2              // 0 << 1, x4 = 0
    nop                 // x4 = -2
    nop
    nop
    sll x4, x2, x5              // 1 << -1, x4 = 0x80000000          
    nop                 // x4 = 0
    nop
    nop
    slt x4, x2, x0              // 1 < 0, no, x4 = 0
    nop                 // x4 = 0x80000000
    nop
    nop
    slt x4, x2, x5              // 1 < -1, no, x4 = 0
    nop                 // x4 = 0
 	nop
    nop
    slt x4, x5, x2              // -1 < 1, yes, x4 = 1
    nop                 // x4 = 0
    nop
    nop
    slt x4, x4, x2              // 1 < 1, no, x4 = 0
    nop                 // x4 = 1
    nop
    nop
    sltu x4, x2, x4              // 1 < 0, no, x4 = 0
    nop                 // x4 = 0
    nop
    nop
    sltu x4, x2, x5              // 1 < 0xfffff, yes, x4 = 1
    nop                 // x4 = 0
 	nop
    nop
    sltu x4, x5, x2              // 0xfffff < 1, no, x4 = 0
    nop                 // x4 = 1
    nop
    nop
    sltu x4, x4, x2              // 0 < 1, no, x4 = 1
    nop                 // x4 = 0
    nop
    nop
    xor x4, x4, x2               // 1 xor 1, x4 = 0             PROBLEM: x4 = 1
    nop                 // x4 = 1
    nop
    nop
    xor x4, x2, x0               // 1 xor 0, x4 = 1
    nop                 // x4 = 0
    nop
    nop
    xor x4, x5, x2               // -1 xor 1, x4 = -2           PROBLEM: x4 = -1
    nop                 // x4 = 1
    nop
    nop
    xor x4, x4, x5               // -2 xor -1, x4 = 1
    nop                 // x4 = -2
    nop
    nop
    srl x4, x3, x2              // 1 >> 1, x4 = 0
    nop                 // x4 = 1
    nop
 	nop
    srl x4, x3, x0              // 1 >> 0, x4 = 1
    nop                 // x4 = 0
    nop
    nop
    srl x4, x5, x2              // -1 >> 1, x4 = 0x7ffff
    nop                 // x4 = 1
    nop
    nop
    srl x4, x0, x2              // 0 >> 1, x4 = 0
    nop                 // x4 = 0x7ffff
    nop
    nop
    srl x4, x2, x5              // 1 >> -1, x4 = 0                  
    nop                 // x4 = 0
    nop
    nop
    sra x4, x3, x2              // 1 >> 1, x4 = 0
    nop                 // x4 = 0
    nop
 	nop
    sra x4, x3, x0              // 1 >> 0, x4 = 1
    nop                 // x4 = 0
    nop
    nop
    sra x4, x5, x2              // -1 >> 1, x4 = 0xfffff
    nop                 // x4 = 1
    nop
    nop
    sra x4, x0, x2              // 0 >> 1, x4 = 0             
    nop                 // x4 = 0xfffff
    nop
    nop
    sra x4, x2, x5              // 1 >> -1, x4 = 0                  
    nop                 // x4 = 0
    nop
    nop
    or x4, x3, x2               // 1 or 1, x4 = 1
    nop                 // x4 = 0
    nop
    nop
    or x4, x2, x0               // 1 or 0, x4 = 1
    nop                 // x4 = 1
    nop
    nop
    or x4, x5, x2               // -1 xor 1, x4 = -1
    nop                 // x4 = 1
    nop
    nop
    or x4, x4, x5               // -1 xor -1, x4 = -1
    nop                 // x4 = -1
    nop
    nop
    and x4, x4, x5               // -1 and -1, x4 = -1
    nop                 // x4 = -1
    nop
    nop
    and x4, x2, x0               // 1 and 0, x4 = 0
    nop                 // x4 = -1
    nop
    nop
    and x4, x3, x2               // 1 and 1, x4 = 1
    nop                 // x4 = 0
    nop
    nop
    and x4, x4, x5               // 1 and -1, x4 = 1
    nop                 // x4 = 1
    nop
    nop
    nop
    halt
    nop
    nop
    nop
    nop


 /*
 	Shift Immediate ALU operations
      
    Suggested tests or unique features of Shift Immediate instructions
    - there are 3 shift immediate operations  
        - slli
        - srli
        - srai
    - logical shifts do not maintain the sign of the operand (the number 
    of bits shifted are padded with 0s) while an arithematic shifts maintain 
    the sign (the number of bits shifted are padded with the sign bit value)
    - both negative and positive values must be tested for each operation

    Will use this test for Assignment 5: Data Path and Instruction Decode
 */
    slli x4, x3, 3                  // 1 << 3, x4 = 8
    nop
    nop
    nop
    slli x4, x5, 1                  // -1 << 1, x4 = -2
    nop                 // x4 = 8
    nop
    nop
    slli x4, x2, -1                 // 1 << -1, x4 = 0x80000000                  
    nop                 // x4 = -2
    nop
    nop
    slli x4, x5, -1                 // -1 << -1, x4 = 0x80000000
    nop                 // x4 = 0x80000000
    nop
    nop
    srli x4, x3, 3                  // 1 >> 3, x4 = 0                   PROBLEM: x4 = 0x8
    nop                 // x4 = 0x80000000
    nop
    nop
    srli x4, x5, 1                  // -1 >> 1, x4 = 0x7fffffff         PROBLEM: x4 = -2
    nop                 // x4 = 0
    nop
    nop
    srli x4, x2, -1                 // 1 >> -1, x4 = 0                 PROBLEM: x4 = 0x80000000
    nop                 // x4 = 0x7fffffff
    nop
    nop
    srli x4, x5, -1                 // -1 >> -1, x4 = 1                PROBLEM: x4 = 0x80000000
    nop                 // x4 = 0
    nop
    nop
    srai x4, x3, 1              // 1 >> 1, x4 = 0
    nop                 // x4 = 1
    nop
 	nop
    srai x4, x3, 0              // 1 >> 0, x4 = 1
    nop                 // x4 = 0
    nop
    nop
    srai x4, x5, 1              // -1 >> 1, x4 = 0xfffff
    nop                 // x4 = 1
    nop
    nop
    srai x4, x0, 1              // 0 >> 1, x4 = 0             
    nop                 // x4 = 0xfffff
    nop
    nop
    srai x4, x2, -1             // 1 >> -1, x4 = 0                          
    nop                 // x4 = 0
    nop
    nop
	nop
 	halt
 	nop
 	nop
 	nop
 	nop
 /*
 	Data hazard detection and forwarding test sequences
    
    - Data forward removes the requirement of putting nops between each 
    instruction.  Starting at this test, there should not be a requirement
    to place nops between instructions
    - Data forwarding must be tested for each register operand, rs1 and rs1,
    for each instruction in the pipeline after the ID (Instruction Decode) stage,
    EX, MEM, and WB.  To test this combination, a minimum of 6 tests are required.

    Will use this test for Assignment 6: Data Hazard and Data Forwarding
 */
 	# addi x2, x0, 1				// load x2 register with 1
 	# addi x3, x0, 2				// load x3 register with 2
 	# addi x4, x0, 3				// load x4 register with 3
 	# addi x5, x0, -1				// load x5 register with -1
	# nop
	# nop
	# nop
	# nop
  	# halt
 	# nop
 	# nop
 	# nop
 	# nop
 /*
 	Branch (b-type) operations

    Suggested tests or unique features of BTYPE (branch) instructions
    - there are 6 BTYPE (branch) operations  
        - beq
        - bne
        - blt
        - bge
        - bltu
        - bgeu
    - there are operations that use unsigned values (bltu & bgeu)
    - both negative and positive operands should be tested
    - branches are comparison operations that need to test the 3 options
         - less than
         - equal
         - greater than
    - a test must ensure that the branch goes to the proper address
    - branch immediates are signed which indicates a branch should test
    both positive (forward) branches and negative (backword) branches
    - You can add new BRANCH labels for testing.  Highly recommended.
    - if a branch test fails, it should branch to the BRANCH_FAIL label to 
    help indicate which branch test fails

    Will use this test for Assignment 7: Branch and Jumps

 */
    xori x2, x2, 3                      // 1 xor 3, x2 = 2
    xori x4, x4, 4                      // 0 xor 4, x4 = 4
    xori x1, x1, 1                      // 0 xor 1, x1 = 1
    xori x3, x3, 2                      // 1 xor 2, x3 = 3

BEQ_BACK:
    addi x2, x2, -1                     // 2 - 1, x2 = 1
    beq x2, x1, BEQ_BACK                // 1 = 1, BEQ_BACK
    beq x5, x3, BEQ_FAIL                // -1 != 1, Should Fail
    beq x2, x3, BEQ_FAIL                // 2 != 1, Should Fail
    beq x0, x0, BEQ_PASS                // 0 = 0, Should Pass

BEQ_FAIL:
	halt		// Branch test has failed, time to debug

BEQ_PASS:
    addi x1, x0, 0                      // 0 + 0, x1 = 0
    addi x2, x0, 2                      // 0 + 2, x2 = 2

// -------------------------------------------------------

BNE_BACK:
    addi x1, x1, 1                      // x1 + 1
    bne x1, x2, BNE_BACK                // 1 != 2, BNE_BACK
    bne x0, x0, BNE_FAIL                // 0 = 0, Should Fail
    bne x5, x3, BNE_PASS                // -1 != 1, Should Pass  

BNE_FAIL:
	halt		// Branch test has failed, time to debug

BNE_PASS:
    addi x1, x0, 0                      // 0 + 0, x1 = 0

// -------------------------------------------------------

BLT_BACK:
    addi x1, x1, 1                      // x1 + 1
    blt x1, x2, BLT_BACK                // 1 < 2, BLT_BACK 
    blt x3, x2, BLT_FAIL                // 3 < 2, Should Fail
    blt x0, x0, BLT_FAIL                // 0 = 0, Should Fail
    blt x5, x3, BLT_PASS                // -1 < 1, Should Pass

BLT_FAIL:
	halt		// Branch test has failed, time to debug

BLT_PASS:
    addi x1, x0, 3                      // 0 + 3, x1 = 3

// -------------------------------------------------------

BGE_BACK:
    addi x1, x1, -1                     // x1 - 1
    bge x1, x2, BGE_BACK                // 2 >= 2, BGE_BACK 
    bge x5, x3, BGE_FAIL                // -1 !>= 1, Should Fail
    bge x2, x5, BGE_PASS                // 2 >= 1, Should Pass

BGE_FAIL:
	halt		// Branch test has failed, time to debug

BGE_PASS:
    addi x1, x0, 0                      // 0 + 0, x1 = 0

// -------------------------------------------------------

BLTU_BACK:
    addi x1, x1, 1                       // 0 + 1
    bltu x1, x2, BLTU_BACK                // 1 < 2, BLTU_BACK                  PROBLEM: Not branching when 1 < 2
    bltu x5, x3, BLTU_FAIL                // 0xfffff !< 3, Should Fail         PROBLEM: Jumping
    bltu x2, x3, BLTU_PASS                // 2 < 3, Should Pass

BLTU_FAIL:
	halt		// Branch test has failed, time to debug

BLTU_PASS:
    addi x1, x0, 3                      // 0 + 3, x1 = 3

// -------------------------------------------------------

BGEU_BACK:
    addi x1, x1, -1                       // 0 - 1
    bgeu x1, x2, BGEU_BACK                // 2 >= 2, BGEU_BACK 
    bgeu x2, x3, BGEU_FAIL                // 2 !>= 3, Should Fail
    bgeu x5, x3, BGEU_PASS                // 0xfffff >= 3, Should Pass

BGEU_FAIL:
	halt		// Branch test has failed, time to debug

BGEU_PASS:
    nop
    nop
    nop
    nop
  	halt
    nop
    nop
    nop
    nop
 /*
 	jump instruction operations

    Suggested tests or unique features of Jump instructions
    - there are 2 jump operations  
        - jalr
        - jal
    - jump operations change the flow of a program without the need to 
    pass a conditional statement such as less than
    - a test must ensure that the jump goes to the proper address
    - jump immediates are signed which indicates a jump should test
    both positive (forward) jumps and negative (backword) jumps
    - jump instructions store the return address, pc + 4, in the rd,
    destination register, which must be tested/validated
    - You can add new JUMP labels for testing.  Highly recommended.
    - if a jump test fails, it should branch to the JUMP_FAIL label to 
    help indicate which jump test fails

    Will use this test for Assignment 7: Branch and Jumps
 */

    jal x0, JAL_AHEAD          // Jump ahead                           PROBLEM: None of the jal instructions are working

JAL_BACK:
	jal x0, JAL_PASS           // Jump to Pass
	jal x0, JAL_FAIL           // Jump to Fail if Jump to Pass fails

JAL_AHEAD:
    jal x0, JAL_BACK           // Jump back
 	jal x0, JAL_FAIL           // Jump to Fail if Jump back fails

JAL_FAIL:
    nop
    nop
    nop
    nop
    halt
    nop
    nop
    nop
    nop

JAL_PASS:
    addi x1, x0, 0                   // Loading in 0
    addi x2, x0, 0                   // Loading in 0
    addi x3, x0, 0                   // Loading in 0
    addi x4, x0, 0                   // Loading in 0

    lui x1, 1                        // Loading 1 into bit 12
    lui x2, 1                        // Loading 1 into bit 12
    lui x3, 1                        // Loading 1 into bit 12
    lui x4, 1                        // Loading 1 into bit 12

    jalr x0, 0x5f4(x1)               // Jump ahead                           

JALR_BACK:
	jalr x0, 0x620(x3)           // Jump to Pass
	jalr x0, 0x5fc(x4)           // Jump to Fail if Jump to Pass fails

JALR_AHEAD:
    jalr x0, 0x5ec(x2)           // Jump back
 	jalr x0, 0x5fc(x4)           // Jump to Fail if Jump back fails

JALR_FAIL:
    nop
    nop
    nop
    nop
    halt
    nop
    nop
    nop
    nop

JALR_PASS:
    nop
    nop
    nop
    nop
    
 /*
 	Store (s-type)  operations

    Suggested tests or unique features of store instructions
    - there are 3 store operations  
        - sw
        - sh
        - sb
    - store immediates are signed which indicates a store should test
    both a positive and negative immediate
    - a byte can be placed into one of the four byte locations of a 
    data word indicating a minimum of 4 sb (store byte) tests
    - a half-word can be placed into two of the four half-word locations
    of a data word indicating a minimum of 2 sh (store half-word) tests
    - you  will be using the memory view of the debugger to validate 
    the store operations
    
    Will use this test for Assignment 8: Stores and Loads
 */
 	// Loading test data into registers for Store / Load tests
    lui x20, 0x210
    srli x20, x20, 12
    lui x30, 0x76543
    or x20, x20, x30                        // x20 = 0x76543210
    lui x21, 0xdef
    srli x21, x21, 12
    lui x30, 0x89abc
    or x21, x21, x30                        // x21 = 0x89abcdef

 	// Load register x10 with base DATA memory location
 	lui x10, (DATA & 0xfff)		            // Use linker to obtain lower 12-bits
 	srli x10, x10, 12				        // Move the lower 12-bits to locations 11..0
    lui x30, ((DATA & 0xfffff000) >> 12)    // Move the upper DATA address bits into upper 20-bits
 	or x10, x10, x30           	        // x10 = DATA address
 	// Load register x11 with base DATA_MINUS location
 	lui x11, (DATA_MINUS & 0xfff)		    // Use linker to obtain lower 12-bits
 	srli x11, x11, 12				        // Move the lower 12-bits to locations 11..0
    lui x30, ((DATA_MINUS & 0xfffff000) >> 12)    // Move the upper DATA address bits into upper 20-bits
 	or x11, x11, x30           	        // x11 = DATA_MINUS address
 	// start of Store Instruction test

	sw x20, 0(x10)                          // Store whole word in x20 in memory address in x10         PROBLEM: Only stores 4 least significant bits
    sw x21, 4(x10)                          // Store whole word in x21 in memory address in 4(x10)      PROBLEM: Only stores 4 least significant bits

    sh x20, 12(x10)                         // Stores 3210 in least significant bits of 12(x10)           
    sh x21, 14(x10)                         // Stores cdef in the most significant bits of 12(x10)

    sb x20, 16(x10)                         // Stores 10 in 16(x10)                                     PROBLEM: Stores halfword 3210
    sb x20, 17(x10)                         // Stores 10 in 17(x10)                                     PROBLEM: Errors
    sb x21, 18(x10)                         // Stores ef in 18(x10)                                     PROBLEM: Stores halfword cdef
    sb x21, 19(x10)                         // Stores ef in 19(x10)                                     PROBLEM: Errors

    sw x20, -4(x11)                         // Stores whole word in -4(x11)                             PROBLEM: Only stores 4 least significant bits
	
    nop
    nop
	nop
	nop
  	halt
  	nop
  	beq x0, x0, LOAD_TEST
  	nop
 /*
 	Data Memory Space for regression test
 	- There are 8 NOP locations which are available
 		to be overwritten for test
 	- Accessing the first data location by 0 offset of x10 => 0(x10)
 	- Accessing the 1st byte in data space is 1 offset of x10 => 1(x10)
 	- Accessing the 2nd half-word in data space is 2 offset of x10 => 2(x10)
 	- Accessing the 2nd word in data space is 4 offset of x10 => 4(x10)
 */
DATA:
 	nop
 	nop
 	nop
 	nop
 	nop
 	nop
 	nop
 	nop
 DATA_MINUS:
    nop
    nop
    nop
    nop

 /*
 	Load operations
    
    Suggested tests or unique features of load instructions
    - there are 5 load operations  
        - lw
        - lh
        - lhu
        - lb
        - lbu
    - load immediates are signed which indicates a load should test
    both a positive and negative immediate
    - a byte can be read from one of the four byte locations of a 
    data word indicating a minimum of 4 lb (load byte) tests
    - a minimum of two unsigned load byte (lbu) to test a byte with 
    bit 7 a 0 and a 1 to validate proper signed bit extension
    - a half-word can be placed into two of the four half-word locations
    of a data word indicating a minimum of 2 lh (load half-word) tests
    - a minimum of two unsigned load byte (lhu) to test a half-word with 
    bit 15 a 0 and a 1 to validate proper signed bit extension
    - You can use the test values in memory from the store testss for the load 
    memory tests
         - You can use the DATA and DATA_MINUS labels that were used for stores
    - if you have branches working at this point, use a branch to validate 
    the proper load operation and upon failure, branch to LOAD_FAIL label to
    indicate a failed load operation to debug
    
    Will use this test for Assignment 8: Stores and Loads
 */
LOAD_TEST:
    lw x1, 0(x10)                          // Load whole word from x10 into x1 = 76543210  
    bne x1, x20, LOAD_FAIL                 // Should not branch
    lw x2, 4(x10)                          // Load whole word from 4(x10) into x2 = 89abcdef 
    bne x2, x21, LOAD_FAIL                 // Should not branch

    lh x3, 14(x10)                         // Loads cdef in least significant bits of x3 = 0xffffcdef           PROBLEM? Didn't sign extend
    lui x6, 0xdef                          // Load lower 12 bits in
    srli x6, x6, 12                        // Shift right
    lui x8, 0xffffc                        // Load upper 20 bits
    or x6, x6, x8                          // Combine
    bne x3, x6, LOAD_FAIL                  // Should not branch
    lh x3, 12(x10)                         // Loads 3210 in the least significant bits of x3 = 0x00003210
    lui x7, 0x210                          // Load lower 12 bits in
    srli x7, x7, 12                        // Shift right
    lui x8, 0x00003                        // Load upper 20 bits
    or x7, x7, x8                          // Combine
    bne x3, x7, LOAD_FAIL                  // Should not branch


    lhu x3, 14(x10)                         // Loads cdef in least significant bits of x3 = 0x0000cdef   
    lui x6, 0xdef                           // Load lower 12 bits in
    srli x6, x6, 12                         // Shift right
    lui x8, 0x0000c                         // Load upper 20 bits
    or x6, x6, x8                           // Combine
    bne x3, x6, LOAD_FAIL                   // Should not branch
    lhu x3, 12(x10)                         // Loads 3210 in the least significant bits of x3 = 0x00003210
    bne x3, x7, LOAD_FAIL                   // Should not branch
                         
    lb x4, 19(x10)                         // Loads ef in x4 = 0xffffffef   
    lui x6, 0xfef                          // Load lower 12 bits in
    srli x6, x6, 12                        // Shift right
    lui x8, 0xfffff                        // Load upper 20 bits
    or x6, x6, x8                          // Combine
    bne x4, x6, LOAD_FAIL                  // Should not branch                    
    lb x4, 18(x10)                         // Loads ef in x4 = 0xffffffef  
    bne x4, x6, LOAD_FAIL                  // Should not branch            
    lb x4, 17(x10)                         // Loads 10 in x4 = 0x00000010  
    lui x7, 0x010                          // Load lower 12 bits in
    srli x7, x7, 12                        // Shift right
    lui x8, 0x00000                        // Load upper 20 bits
    or x7, x7, x8                          // Combine
    bne x4, x7, LOAD_FAIL                  // Should not branch                                 
    lb x4, 16(x10)                         // Loads 10 in x4 = 0x00000010           
    bne x4, x7, LOAD_FAIL                  // Should not branch                   
    
    lbu x4, 19(x10)                         // Loads ef in x4 = 0x000000ef    
    ori x6, x0, 0x000000ef                  // Set x6 = to what x4 should be
    bne x4, x6, LOAD_FAIL                   // Should not branch             
    lbu x4, 18(x10)                         // Loads ef in x4 = 0x000000ef
    bne x4, x6, LOAD_FAIL                   // Should not branch           
    lbu x4, 17(x10)                         // Loads 10 in x4 = 0x00000010 
    bne x4, x7, LOAD_FAIL                   // Should not branch                 
    lbu x4, 16(x10)                         // Loads 10 in x4 = 0x00000010                                  
    bne x4, x7, LOAD_FAIL                   // Should not branch
    
    lw x5, -4(x11)                         // Loads whole word from -4(x11) into x5 = 0x76543210    
    bne x5, x20, LOAD_FAIL                 // Should not branch   
	
	nop
	nop
	nop
	nop
  	halt                 // SUCCESS!!!
 	nop
 	nop
 	nop
 	nop

 LOAD_FAIL:							// Using branch statements, if load does not
 	nop								// return result expected, branch to LOAD_FAIL label
 	nop
 	nop
    nop
 	halt
 	nop
 	nop
 	nop
 	nop



