.syntax unified

.cpu cortex-m4

.thumb



#define A #4

#define B #3

#define C #2



.global vtable_kernel

.global __kernel_reset__



.type vtable_kernel, %object

.type __kernel_reset__, %function



.section .interrupt_vector

vtable_kernel:

    .word __stack_start

    .word __kernel_reset__+1

    .size vtable_kernel, .-vtable_kernel



.section .rodata

    message: .asciz "Result in R5:\n"



.section .data

    valA: .word 4

    valB: .word 3

    valC: .word 2



.section .text

__kernel_reset__:



    ldr r0, =message

    bl dbgput_line



    // Завантаження значень з пам’яті

    ldr r0, =valA

    ldr r1, [r0]

    ldr r0, =valB

    ldr r2, [r0]

    ldr r0, =valC

    ldr r3, [r0]



    // Обчислення A * B

    mul r4, r1, r2



    // Порівняння з 10

    cmp r4, #10

    bge greater_or_equal



less_than:

    // r5 = (A & B) * C

    and r5, r1, r2

    mul r5, r5, r3

    b done



greater_or_equal:

    // r5 = (A | B) * C

    orr r5, r1, r2

    mul r5, r5, r3



done:

    mov r0, r5

    bl dbgput_num



loop:

    b loop

