/*
 * merl-gpio.S
 *
 * Firmware for testing the GPIO pin.
 *
 * Copyright (C) 2021-2022  MERL <merl@uit.edu>
 * SPDX-License-Identifier: MIT
 */

#define GPIO_DATA	0x21000000
#define GPIO_OE     0x21000004
#define GPIO_PU     0x21000008
#define GPIO_PD     0x2100000c
#define GPIO_STORE(x)	(0)(x)

	.section .text.start
	.global _start
_start:
    // Set configuration
	li a0, GPIO_DATA
    li a1, GPIO_PD
    li a4, GPIO_OE

1:
	sw zero, 0(a0)
	addi    a0, a0, 4
	bne	a0, a1, 1b

    // config
    li s3, 1
	sw s3, GPIO_STORE(a4)


    // assign value
    li a1, 1
    
    // loop counter
    li a2, 1
    li a3, 100

loop:
    count:
        sw a1, 0(a0)
        addi a2, a2, 1
        bne a2, a3, count
    xori a1, a1, 1        // invert    
    j loop

