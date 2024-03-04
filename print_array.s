.data
A: .word 11, 22, 33, 44, 55
newline: .string "\n"
space: .string " "

.text

main:
    la a0, A  # Loading the starting address of array A to a0
    addi a1, x0, 5  # passing the array size value to a1
    jal print_array

    addi a0, x0, 10
    addi a1, x0, 0
    ecall # Terminate ecall

print_array:
    addi t0, x0, 0  # let t0 be 0 value be t0

loop1:
    bge t0, a1, exit1  # if t0 > a1 then branch to exit1
    slli t1, t0, 2  # i*4
    add t2, t1, a0  # get A[i]
    lw t3, 0(t2)  # load value of A[i]

    addi sp, sp, -8  # decrease stack
    sw a1, 4(sp)  # save a1
    sw a0, 0(sp)  # save a0

    # print A[i]
    addi a0, zero, 1  # tells the system to print int
    mv a1, t3  # set what we're going to print
    ecall

    # print space
    addi a0, x0, 4  # tells the system to print string
    la a1, space  # set the space to print
    ecall
    lw a1, 4(sp)  # load word a1 back
    lw a0, 0(sp)  # load word a0 back

    addi sp, sp, 8  # give the stack number back
    addi t0, t0, 1  # i++
    j loop1

exit1:
    # print newline
    addi a0, x0, 4
    la a1, newline
    ecall

    # restore ra and return
    lw ra, 0(sp)
    ecall
    jr ra


