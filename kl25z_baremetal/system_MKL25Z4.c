#include "system_MKL25Z4.h"

/* Default reset clock ≈ 20.97 MHz (FEI) */
uint32_t SystemCoreClock = 20971520u;

void SystemInit(void)
{
    /* Minimal init
     * - no PLL
     * - no clock switching
     * - flash defaults
     */
}

void SystemCoreClockUpdate(void)
{
    /* Static for now */
}
