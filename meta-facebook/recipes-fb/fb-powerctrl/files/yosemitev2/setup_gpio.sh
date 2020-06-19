#!/bin/bash

. /usr/sbin/ast-functions

# SLOT1_PRSNT_N, GPIOAA0 (208)
gpio_export AA0

# SLOT2_PRSNT_N, GPIOAA1 (209)
gpio_export AA1

# SLOT3_PRSNT_N, GPIOAA2 (210)
gpio_export AA2

# SLOT4_PRSNT_N, GPIOAA3 (211)
gpio_export AA3


# PWR_SLOT1_BTN_N, 1S Server power out, on GPIO D1(25)
gpio_set D1 1

# PWR_SLOT2_BTN_N, 1S Server power out, on GPIO D3(27)
# Make sure the Power Control Pin is Set properly
gpio_set D3 1

# PWR_SLOT3_BTN_N, 1S Server power out, on GPIO D5(29)
gpio_set D5 1

# PWR_SLOT4_BTN_N, 1S Server power out, on GPIO D7(31)
gpio_set D7 1



# Power LED for Slot#2:GPIOM0 (96)
gpio_set M0 0

# Power LED for Slot#1: GPIOM1 (97)
gpio_set M1 0

# Power LED for Slot#4: GPIOM2 (98)
gpio_set M2 0

# Power LED for Slot#3: GPIOM3 (99)
gpio_set M3 0


# SLOT1_POWER_EN: GPIOI0 (64)
gpio_export I0

# SLOT2_POWER_EN: GPIOI1 (65)
gpio_export I1

# SLOT3_POWER_EN: GPIOI2 (66)
gpio_export I2

# SLOT4_POWER_EN: GPIOI3 (67)
gpio_export I3


# LED POST CODES: 8 GPIO signals

# LED_POSTCODE_0: GPIOG0 (48)
# To use GPIOG0, SCU84[0] must be 0
#devmem_clear_bit $(scu_addr 84) 0

#gpio_set G0 0

# LED_POSTCODE_1: GPIOG1 (49)
# To use GPIOG1, SCU84[1] must be 0
#devmem_clear_bit $(scu_addr 84) 1

#gpio_set G1 0

# LED_POSTCODE_2: GPIOG2 (50)
# To use GPIOG2, SCU84[2] must be 0
#devmem_clear_bit $(scu_addr 84) 2

#gpio_set G2 0

# LED_POSTCODE_3: GPIOG3 (51)
# To use GPIOG3, SCU84[3] must be 0
#devmem_clear_bit $(scu_addr 84) 3

#gpio_set G3 0

# upper digt display
# LED_POSTCODE_4: GPIOP4 (124)
#gpio_set P4 0

# LED_POSTCODE_5: GPIOP5 (125)
#gpio_set P5 0

# LED_POSTCODE_6: GPIOP6 (126)
#gpio_set P6 0

# LED_POSTCODE_7: GPIOP7 (127)
#gpio_set P7 0
