/* Include Files */
#include "xgpio.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xstatus.h"

#include "counter.h"
/* Definitions */
#define GPIO_DEVICE_ID XPAR_XGPIO_0_BASEADDR  /* GPIO device LEDs & switches are connected to */
#define LED 0x0000           /* Initial LED value - 0000 */
#define LED_DELAY 10000000   /* Software delay length */
#define LED_CHANNEL 1        /* GPIO port for LEDs */
#define SWITCHES_CHANNEL 2   /* GPIO port for SWITCHES */
#define printf xil_printf    /* smaller, optimized printf */
XGpio LEDInst, SWITCHESInst; /* GPIO Device driver instance */
int CounterLeds(void) {
  volatile int Delay;
  u32 SWITCHES;
  u32 MASK = 0x0003; /* Masks status of switches SW2 and SW3 */
  int led = LED;     /* Hold current LED value. Initialize to LED definition */
  while (1) {
    /* Receives the status of the switches and masks SW2 and SW3 */
    /* Only SW0 and SW1 status determines the counter operation */
    SWITCHES = (MASK & (XGpio_DiscreteRead(&SWITCHESInst, SWITCHES_CHANNEL)));
    /* Verifies if the counter is enabled (SW1=1) */
    if ((SWITCHES == 0x0000) || (SWITCHES == 0x0001)) {
      led = led;
    } else {
      /* If the counter is enable and counting up (SW0=1) reset it if it
       * overloads */
      if (SWITCHES == 0x0003) {
        if (led == 0xFFFF) {
          led = 0x0000;
        } else {
          /* or increment the counter otherwise */
          led = led + 1;
        }
      }
      /* If the counter is enable and counting down (SW0=0) set it if it reaches
       * zero */
      if (SWITCHES == 0x0002) {
        if (led == 0x0000) {
          led = 0xFFFF;
        } else {
          /* decrement the counter otherwise*/
          led = led - 1;
        }
      }
    }
    /* Write output to the LEDs */
    XGpio_DiscreteWrite(&LEDInst, LED_CHANNEL, led);
    /* Wait a small amount of time so that the LED counting is visible */
    for (Delay = 0; Delay < LED_DELAY; Delay++)
      ;
  }
  return XST_SUCCESS; /* Should be unreachable */
}

int start() {

  /* Initialize the GPIO */
  int Status;
  Status = XGpio_Initialize(&LEDInst, GPIO_DEVICE_ID);
  if (Status != XST_SUCCESS)
    return XST_FAILURE;
  /* Initialize the SWITCHES GPIO */
  Status = XGpio_Initialize(&SWITCHESInst, GPIO_DEVICE_ID);
  if (Status != XST_SUCCESS)
    return XST_FAILURE;
  /* Set IO directions */
  /* Parameters */
  /* InstancePtr is a pointer to an XGpio instance to be worked on */
  /* Channel contains the channel of the GPIO (1 or 2) to operate on */
  /* DirectionMask is a bitmask specifying which IOs are input and which are
   * output. */
  /* Bits set to 0 are output and bits set to 1 are input */
  /* Set all LEDs IO direction to outputs */
  XGpio_SetDataDirection(&LEDInst, LED_CHANNEL, 0x0);
  /* Set all switches direction to inputs */
  XGpio_SetDataDirection(&SWITCHESInst, SWITCHES_CHANNEL, 0xF);
  /* Call the function Counter */
  CounterLeds();

  return 0;
}