.syntax unified
.cpu cortex-m0plus
.thumb

.global Reset_Handler
.global Default_Handler

.extern _estack
.extern _sidata
.extern _sdata
.extern _edata
.extern _sbss
.extern _ebss

.section .isr_vector, "a", %progbits
__isr_vector:
    .word _estack
    .word Reset_Handler
    .word Default_Handler   /* NMI */
    .word Default_Handler   /* HardFault */
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word Default_Handler   /* SVC */
    .word 0
    .word 0
    .word Default_Handler   /* PendSV */
    .word Default_Handler   /* SysTick */

.section .text
.thumb_func
Reset_Handler:
    /* Copy .data from flash to RAM */
    ldr r0, =_sdata
    ldr r1, =_edata
    ldr r2, =_sidata
CopyData:
    cmp r0, r1
    bcc CopyDataLoop
    b InitBSS

CopyDataLoop:
    ldr r3, [r2]
    str r3, [r0]
    adds r0, #4
    adds r2, #4
    cmp r0, r1
    bcc CopyDataLoop

InitBSS:
    /* Zero .bss */
    ldr r0, =_sbss
    ldr r1, =_ebss
    movs r2, #0
ZeroBSS:
    cmp r0, r1
    bcc ZeroBSSLoop
    b CallMain

ZeroBSSLoop:
    str r2, [r0]
    adds r0, #4
    cmp r0, r1
    bcc ZeroBSSLoop

CallMain:
    bl SystemInit
    bl main

Default_Handler:
    b .
