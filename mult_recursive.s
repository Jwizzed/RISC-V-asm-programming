.text
main:
    # pass the first argument to a0
    addi a0, x0, 110
    # pass the second argument to a1
    addi a1, x0, 50
    jal mult

    # answer
    mv a1, a0  # move the a0 (returned value) to a1 for printing

    # printing
    addi a0, x0, 1  # Tells the system to print an integer
    ecall

    # exit cleanly
    addi a0, x0, 10
    ecall

 mult:
    # base case
    # compare a1 with 1, if the two are equal you exit the mult function
    addi t0, x0, 1  # Create temporary variable of 1
    beq a1, t0, exit_base_case  # branch to exit_base_case

    # recursive case
    addi sp, sp, -8
    sw a0, 0(sp)
    sw ra, 4(sp)  # storing the ra value on to the stack

    addi a1, a1, -1  # b-1
    jal mult  # mult (a, b-1);

    mv t1, a0  # move an answer to t1
    lw a0, 0(sp)  # load the original a before call to mult
    add a0, a0, t1  # answer
    lw ra, 4(sp)  # load ra back
    addi sp, sp 8
    jr ra

 exit_base_case:
    jr ra