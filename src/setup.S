INITSEG = 0x9000
SYSSEG  = 0x1000
SETUPSEG = 0x9020

.code16
.text
.globl _start_setup

_start_setup:
    movw %cs, %ax
    movw %ax, %ds
    movw %ax, %es

    movw $setup_msg, %ax
    movw %ax, %bp
    movw $0x01301, %ax
    movw $0x0c, %bx
    movw $16, %cx
    movb $3, %dh
    movb $0, %dl
    int  $0x010

    movw $INITSEG, %ax
    movw %ax, %ds
    movb $0x03, %ah
    xor  %bh,  %bh
    int  $0x10
    movw %dx, (0)
    movb $0x88, %ah
    int  $0x15
    movw %ax, (2)

    movb $0x0f, %ah
    int  $0x10
    movw %bx, (4)
    movw %ax, (6)
    movb $0x12, %ah
    movb $0x10, %bl
    int  $0x10
    movw %ax, (8)
    movw %bx, (10)
    movw %cx, (12)
    movw $0x5019, (14)

    movw $0x0000, %ax
    movw %ax, %ds
    ldsw (4 * 0x41), %si
    movw $INITSEG, %ax
    movw %ax, %es
    movw $0x0080, %di
    movw $0x10, %cx
    rep
    movsb

    /* get hd1 data */
    movw $0x0000, %ax
    movw %ax, %ds
    ldsw (4 * 0x46), %si
    movw $INITSEG, %ax
    movw %ax, %es
    movw $0x0090, %di
    movw $0x10, %cx
    rep
    movsb

    movw $0x1500, %ax
    movb $0x81, %dl
    int  $0x13
    jc   no_disk1
    cmpb $3, %ah
    je   is_disk1
no_disk1:
    movw $INITSEG, %ax
    movw %ax, %es
    movw $0x0090, %di
    movw $0x10, %cx
    movw $0x00, %ax
    rep
    stosb

is_disk1:
    /* prepare for protection mode */
    cli

loop:
    jmp loop

setup_msg:
  .ascii "setup is running"

