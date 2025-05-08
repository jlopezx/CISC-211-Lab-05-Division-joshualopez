/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
@ Define the globals so that the C code can access them
/* define and initialize global variables that C can access */
/* create a string */
.global nameStr
.type nameStr,%gnu_unique_object
    
/*** STUDENTS: Change the next line to your name!  **/
nameStr: .asciz "Joshua Lopez"  

.align   /* realign so that next mem allocations are on word boundaries */
 
/* initialize a global variable that C can access to print the nameStr */
.global nameStrPtr
.type nameStrPtr,%gnu_unique_object
nameStrPtr: .word nameStr   /* Assign the mem loc of nameStr to nameStrPtr */
 
/* define and initialize global variables that C can access */

.global dividend,divisor,quotient,mod,we_have_a_problem
.type dividend,%gnu_unique_object
.type divisor,%gnu_unique_object
.type quotient,%gnu_unique_object
.type mod,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
dividend:          .word     0  
divisor:           .word     0  
quotient:          .word     0  
mod:               .word     0 
we_have_a_problem: .word     0

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: 
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    mov r0,r0
.endif
    
    /** note to profs: asmFunc.s solution is in Canvas at:
     *    Canvas Files->
     *        Lab Files and Coding Examples->
     *            Lab 5 Division
     * Use it to test the C test code */
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    
    /*Assigns dividend and divisor's mem addresses to registers and assigns them values*/
    ldr r2, =dividend	/*Assigns dividend's mem address to r2 to hold its address*/
    str r0, [r2]	/*Stores the test value into dividend's value to truly make it dividend's value*/
    ldr r0, [r2]	/*Assigns the value from dividend's mem address back into r0 to make use of r0*/
    ldr r3, =divisor	/*Uses register 3 to store divisor's mem address*/
    str r1, [r3]	/*Store the test value into divisor's value to truly make it divisor's value*/
    ldr r1, [r3]	/*Store the value from divisor's mem address back into r1 to make use of r1*/
    
    /*Assigns quotient, mod, and we_have_a_problem to registers and sets them to 0*/
    mov r8, 0		/*Let r8 hold 0 to initialize my quotient, mod, and we_have_a_problem labels*/
    ldr r4, =quotient	/*Use register 4 to hold quotient's mem address*/
    str r8, [r4]	/*Initialize quotient to 0*/
    ldr r5, =mod	/*Use register 5 to hold mod's mem address*/
    str r8, [r5]	/*Initialize mod to 0*/
    ldr r6, =we_have_a_problem /*Use reg 6 to hold mem address*/
    str r8, [r6]	/*Initialize we_have_a_problem to 0*/
    
    /*Checks for 0 in inputs. Test case 3, 6, & 7 wants an error for any 0 inputs, 
      However, in test case #6 0/5 should not be an error, 0/5 correctly equals 0 with no errors*/
    cmp r0, 0		/*Checks dividend for 0 input*/
    beq error		/*If the dividend is 0, it will branch to error for error handling*/
    cmp r1, 0		/*Compares divisor for 0 input*/
    beq error		/*If the divisor is 0, it will branch to error for error handling*/
    
    /*Compares the dividend with the divisor to handle the division process.
      If less than, loop ends or doesn't start at all, otherwise it will loop and subtract until less than */
    loop:			/*Loop label to repeat the subtraction and incrementation*/
	cmp r0, r1		/*Used to check if the dividend is less than the divisor, if not, loop*/
	blo remainder_handle	/*blo (for unsigned) is checked to see if the dividend(r0) is less than the divisor(r1), 
				  if it is, it will branch to the remainder_handle label where the remainder and quotient values
				  will be assigned to their proper labels*/
	sub r0, r0, r1		/*This will subtract the dividend with the divisor to handle the first or next division iteration*/
	add r8, r8, 1		/*Increments quotient by 1 meaning that the code iterated the loop once and it 
				  "divided" at least 1 time. Remember r8 has already been assigned 0 and will act as a base*/
	b loop			/*Loops back to repeat the dividend-divisor comparison until dividend is less than 
				  the divisor*/
    
    remainder_handle:
	str r8, [r4]		/*r8 holds the quotient if the loop had no error, and it will store it into the quotient*/
	str r0, [r5]		/*Assign the dividend to the remainder(mod)*/
	ldr r0, =quotient	/*Per the professor's request, the mem address of the quotient is assigned to r0*/
	
	b done			/*Division is done, and will branch to done*/
	
    error:
	mov r8, 1		/*r8 is used as a temp reg to hold 1 to use for later*/
	str r8, [r6]		/*Stores 1 into we_have_a_problem meaning it was activated*/
	ldr r0, =quotient	/*Per the professor's request, the mem address of the quotient is assigned to r0*/
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    mov r0,r0 /* these are do-nothing lines to deal with IDE mem display bug */
    mov r0,r0 /* this is a do-nothing line to deal with IDE mem display bug */

screen_shot:    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




