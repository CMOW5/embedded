#include "MKL25Z4.h"

int main(void)
{
    /* Enable clock to PORTB */
    SIM->SCGC5 |= SIM_SCGC5_PORTB_MASK;

    /* PTB18 = LED on FRDM-KL25Z */
    PORTB->PCR[18] = PORT_PCR_MUX(1);
    PTB->PDDR |= (1 << 18);

    while (1) {
        PTB->PTOR = (1 << 18);   // toggle LED
        for (volatile uint32_t i = 0; i < 500000; i++);
    }
}
