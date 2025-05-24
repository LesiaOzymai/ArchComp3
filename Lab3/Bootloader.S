.syntax unified

.cpu cortex-m4     

.thumb            



.global bootload        



.section .rodata        

image:           .incbin "kernel.bin"         

end_of_image:                                     

str_boot_start:  .asciz "bootloader start"     

str_boot_end:    .asciz "bootload end"         

str_boot_indicate: .asciz "#"                  



.section .text            

bootload:                 



   

    ldr r0, =str_boot_start     

    bl dbgput_line              



   

    ldr r1, =end_of_image    

    ldr r3, =image              

    ldr r2, =_ram_start         

    ldr r4, =12                 

    

    add r2, r2, r1              

    sub r2, r2, r3              



copy_loop:                      

    sub r1, r1, r4              

    sub r2, r2, r4              



    ldm r1, {r5, r6, r7}        

    stm r2, {r5, r6, r7}        



    cmp r1, r3                  

    bhi copy_loop               



    bl newline                  





    ldr r0, =str_boot_end       

    bl dbgput_line              





    ldr r2, =_ram_start         

    ldr r0, [r2, #4]            

    bx r0                       

bootload_end:                  

    b bootload_end      

