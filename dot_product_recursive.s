.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
size: .word 5
message: .string "The dot product is: "
newline: .string "\n"

.text
main:
    la a0, a  # Load a into a0
    la a1, b  # Load b into a1
    lw a2, size  # Load size into a2

    # get answer
    jal dpr  # Jump and link to dot_product_recursive
    mv t0, a0  # Move the answer to t0

    # print message
    addi a0, x0, 4  # Tells the system to print a string
    la a1, message
    ecall

    # print answer
    addi a0, x0, 1  # Tells the system to print an integer
    mv a1, t0  # Move the answer to a1
    ecall

    # print newline
    addi a0, x0, 4  # Tells the system to print a string
    la a1, newline
    ecall

    # Exit cleanly
    addi a0, x0, 10
    ecall

dpr:
    # Base case
    addi t0, x0, 1  # Create a temporary t0 and assign 1 to it
    beq a2, t0, base_case  # if b == 1 then exit the recursion

    addi sp, sp, -12
    sw ra, 0(sp)  # storing the ra value on to the stack
    sw a0, 4(sp)  # storing the a on to the stack
    sw a1, 8(sp)  # storing the b on to the stack

    addi a0, a0, 4  # a+1 in hex
    addi a1, a1, 4  # b+1 in hex
    addi a2, a2, -1 # size - 1
    jal dpr  # dpr(a+1, b+1, size-1);

    lw ra, 0(sp)  # restore ra
    lw t1, 4(sp)  # load the original a before call to dpr (not using a0 because we want the accumulate answer)
    lw t2, 8(sp)  # load the original b before call to dpr

    lw t1, 0(t1)  # Load a[0]
    lw t2, 0(t2)  # Load b[0]

    mul t3, t2, t1  # a[0] * b[0]
    add a0, a0, t3  # accumulate answer

    addi sp, sp 12
    jr ra

base_case:
    lw t1, 0(a0)  # Get a[0]
    lw t2, 0(a1)  # Get b[0]
    mul a0, t1, t2  # a[0] * b[0]
    jr ra