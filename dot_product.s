.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
message: .string "The dot product is: "

.text
main:
    addi x5, x0, 0  # Initial i = 0 and assign it to x5
    addi x6, x0, 0  # Initial sop = 0 and assign it to x6

    la x7, a  # Load address of array a and assign it to x7
    la x8, b  # Load address of array b and assign it to x8

    addi x9, x0, 5  # Initial x9 and set it to 5 (number of loop)

loop:
    bge x5, x9, exit  # if i>= 5 then branch to exit

    slli x18, x5, 2  # assign i*4 to x18
    add x19, x18, x7  # get a[i] and assign to x19
    add x20, x18, x8  # get b[i] and assign to x20

    lw x21, 0(x19)  # get the value of a[i]
    lw x22, 0(x20)  # get the value of b[i]

    mul x23, x21, x22  # get the value of a[i] * b[i] and assign to x23
    add x6, x6, x23  # sop += a[i] * b[i]

    addi x5, x5, 1  # i = i + 1
    j loop

exit:
    addi a0, x0 , 4  # tells the system to print string
    la a1, message  # Set the string to be message
    ecall

    addi a0, x0, 1  # tells the system to print int
    add a1, x0, x6  # set the sop to print
    ecall

    addi a0, x0, 10  # tells the system to exit
    ecall
