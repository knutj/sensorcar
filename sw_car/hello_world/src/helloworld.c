/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include <xil_io.h>

//pwm pins for speed
#define PWM_BASE_ADDRESS 0x43c00000
// Define register offsets based on your PWM IP documentation
#define PWM_CONTROL_REG_OFFSET 0x00
#define PWM_PERIOD_REG_OFFSET 0x04
#define PWM_DUTY_CYCLE_REG_OFFSET_1 0x08
#define PWM_DUTY_CYCLE_REG_OFFSET_2 0x0C
#define PWM_DUTY_CYCLE_REG_OFFSET_3 0x10
#define PWM_DUTY_CYCLE_REG_OFFSET_4 0x14



void init_pwm(u32 baseAddr, u32 period) {
    Xil_Out32(baseAddr + PWM_PERIOD_REG_OFFSET, period);
    Xil_Out32(baseAddr + PWM_CONTROL_REG_OFFSET, 0x01); // Enable PWM, assuming bit 0 is the enable bit
}

void set_pwm_duty_cycle(u32 baseAddr, int motor, u32 duty_cycle) {
    u32 offset;
    switch (motor) {
        case 1: offset = PWM_DUTY_CYCLE_REG_OFFSET_1; break;
        case 2: offset = PWM_DUTY_CYCLE_REG_OFFSET_2; break;
        case 3: offset = PWM_DUTY_CYCLE_REG_OFFSET_3; break;
        case 4: offset = PWM_DUTY_CYCLE_REG_OFFSET_4; break;
        default: return; // Invalid motor number
    }
    Xil_Out32(baseAddr + offset, duty_cycle);
}

int main()
{
    init_platform();

    u32 period = 20000; // For example, a 20ms period

    init_pwm(PWM_BASE_ADDRESS, period);

    // Set initial duty cycle for each motor
    set_pwm_duty_cycle(PWM_BASE_ADDRESS, 1, 1500); // Motor 1
    set_pwm_duty_cycle(PWM_BASE_ADDRESS, 2, 1500); // Motor 2
    set_pwm_duty_cycle(PWM_BASE_ADDRESS, 3, 1500); // Motor 3
    set_pwm_duty_cycle(PWM_BASE_ADDRESS, 4, 1500); // Motor 4

    print("Hello World\n\r");
    print("Successfully ran Hello World application");
    cleanup_platform();
    return 0;
}