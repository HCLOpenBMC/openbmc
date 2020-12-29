#!/bin/sh

#POWER_STATUS_SERVICE="xyz.openbmc_project.State.Chassis$1"
#POWER_STATUS_OBJPATH="/xyz/openbmc_project/state/chassis$1"
#POWER_STATUS_INTERFACE="xyz.openbmc_project.State.Chassis"
#POWER_STATUS_PROPERTY="CurrentPowerState"

POWER_STATUS1_SERVICE="xyz.openbmc_project.State.Chassis1"
POWER_STATUS1_OBJPATH="/xyz/openbmc_project/state/chassis1"

POWER_STATUS2_SERVICE="xyz.openbmc_project.State.Chassis2"
POWER_STATUS2_OBJPATH="/xyz/openbmc_project/state/chassis2"

POWER_STATUS3_SERVICE="xyz.openbmc_project.State.Chassis3"
POWER_STATUS3_OBJPATH="/xyz/openbmc_project/state/chassis3"

POWER_STATUS4_SERVICE="xyz.openbmc_project.State.Chassis4"
POWER_STATUS4_OBJPATH="/xyz/openbmc_project/state/chassis4"

POWER_STATUS_INTERFACE="xyz.openbmc_project.State.Chassis"
POWER_STATUS_PROPERTY="CurrentPowerState"

LED_SERVICE="xyz.openbmc_project.LED.GroupManager"
LED_POWER_OBJPATH="/xyz/openbmc_project/led/groups/power_led"
LED_SYSTEM_OBJPATH="/xyz/openbmc_project/led/groups/system_led"
LED_INTERFACE="xyz.openbmc_project.Led.Group"
LED_PROPERTY="Asserted"

LED1_POWER_ON_OBJPATH="/xyz/openbmc_project/led/groups/power_on_led1"
LED2_POWER_ON_OBJPATH="/xyz/openbmc_project/led/groups/power_on_led2"
LED3_POWER_ON_OBJPATH="/xyz/openbmc_project/led/groups/power_on_led3"
LED4_POWER_ON_OBJPATH="/xyz/openbmc_project/led/groups/power_on_led4"

LED1_POWER_OFF_OBJPATH="/xyz/openbmc_project/led/groups/power_off_led1"
LED2_POWER_OFF_OBJPATH="/xyz/openbmc_project/led/groups/power_off_led2"
LED3_POWER_OFF_OBJPATH="/xyz/openbmc_project/led/groups/power_off_led3"
LED4_POWER_OFF_OBJPATH="/xyz/openbmc_project/led/groups/power_off_led4"

LED1_SYSTEM_ON_OBJPATH="/xyz/openbmc_project/led/groups/system_on_led1"
LED2_SYSTEM_ON_OBJPATH="/xyz/openbmc_project/led/groups/system_on_led2"
LED3_SYSTEM_ON_OBJPATH="/xyz/openbmc_project/led/groups/system_on_led3"
LED4_SYSTEM_ON_OBJPATH="/xyz/openbmc_project/led/groups/system_on_led4"

LED1_SYSTEM_OFF_OBJPATH="/xyz/openbmc_project/led/groups/system_off_led1"
LED2_SYSTEM_OFF_OBJPATH="/xyz/openbmc_project/led/groups/system_off_led2"
LED3_SYSTEM_OFF_OBJPATH="/xyz/openbmc_project/led/groups/system_off_led3"
LED4_SYSTEM_OFF_OBJPATH="/xyz/openbmc_project/led/groups/system_off_led4"

KNOB_SELECTOR_SERVICE="xyz.openbmc_project.Chassis.Buttons"
KNOB_SELECTOR_OBJPATH="/xyz/openbmc_project/Chassis/Buttons/Selector0"
KNOB_SELECTOR_INTERFACE="xyz.openbmc_project.Chassis.Buttons.Selector"
KNOB_SELECTOR_PROPERTY="Position"

echo /sys/class/gpio/gpio792

echo 792 > /sys/class/gpio/export

echo low > /sys/class/gpio/gpio792/direction

while true; do

    position=$(busctl get-property $KNOB_SELECTOR_SERVICE $KNOB_SELECTOR_OBJPATH $KNOB_SELECTOR_INTERFACE $KNOB_SELECTOR_PROPERTY \
              |  awk '{print $NF;}')

    echo "Knob Position : $position"

    if [ "$position" = "5" ]
    then
         busctl set-property $LED_SERVICE $LED_POWER_OBJPATH $LED_INTERFACE $LED_PROPERTY b true

         echo " $LED_POWER_OBJPATH is Asserted"

         busctl set-property $LED_SERVICE $LED1_POWER_ON_OBJPATH $LED_INTERFACE $LED_PROPERTY b false
         busctl set-property $LED_SERVICE $LED2_POWER_ON_OBJPATH $LED_INTERFACE $LED_PROPERTY b false
         busctl set-property $LED_SERVICE $LED3_POWER_ON_OBJPATH $LED_INTERFACE $LED_PROPERTY b false
         busctl set-property $LED_SERVICE $LED4_POWER_ON_OBJPATH $LED_INTERFACE $LED_PROPERTY b false

         busctl set-property $LED_SERVICE $LED1_POWER_OFF_OBJPATH $LED_INTERFACE $LED_PROPERTY b false
         busctl set-property $LED_SERVICE $LED2_POWER_OFF_OBJPATH $LED_INTERFACE $LED_PROPERTY b false
         busctl set-property $LED_SERVICE $LED3_POWER_OFF_OBJPATH $LED_INTERFACE $LED_PROPERTY b false
         busctl set-property $LED_SERVICE $LED4_POWER_OFF_OBJPATH $LED_INTERFACE $LED_PROPERTY b false

    elif [ "$position" = "1" ]
    then

         power=$(busctl get-property $POWER_STATUS1_SERVICE $POWER_STATUS1_OBJPATH $POWER_STATUS_INTERFACE $POWER_STATUS_PROPERTY \
              | cut  -d'"' -f2 |  cut -d"." -f6)

         echo "Power status 1 : $power"

         busctl set-property $LED_SERVICE $LED_POWER_OBJPATH $LED_INTERFACE $LED_PROPERTY b false

         health=Good

         if [ "$power" = "On" ] && [ "$health" = "Good" ]
         then 
              busctl set-property $LED_SERVICE $LED1_POWER_ON_OBJPATH $LED_INTERFACE $LED_PROPERTY b true
              echo " $LED1_POWER_ON_OBJPATH is Asserted"

         elif [ "$power" = "Off" ] && [ "$health" = "Good" ]
         then
              busctl set-property $LED_SERVICE $LED1_POWER_OFF_OBJPATH $LED_INTERFACE $LED_PROPERTY b true
              echo " $LED1_POWER_OFF_OBJPATH is Asserted"

         elif [ "$power" = "On" ] && [ "$health" = "Bad" ]
         then
              busctl set-property $LED_SERVICE $LED1_SYSTEM_ON_OBJPATH $LED_INTERFACE $LED_PROPERTY b true
              echo " $LED1_SYSTEM_ON_OBJPATH is Asserted"

         elif [ "$power" = "Off" ] && [ "$health" = "Bad" ]
         then
              busctl set-property $LED_SERVICE $LED1_SYSTEM_OFF_OBJPATH $LED_INTERFACE $LED_PROPERTY b true
              echo " $LED1_SYSTEM_OFF_OBJPATH is Asserted"

         fi

    elif [ "$position" = "2" ]
    then

         power=$(busctl get-property $POWER_STATUS2_SERVICE $POWER_STATUS2_OBJPATH $POWER_STATUS_INTERFACE $POWER_STATUS_PROPERTY \
              | cut  -d'"' -f2 |  cut -d"." -f6)

         echo "Power status 2 : $power"

         busctl set-property $LED_SERVICE $LED_POWER_OBJPATH $LED_INTERFACE $LED_PROPERTY b false

         health=Bad

         if [ "$power" = "On" ] && [ "$health" = "Good" ]
         then
              busctl set-property $LED_SERVICE $LED2_POWER_ON_OBJPATH $LED_INTERFACE $LED_PROPERTY b true
              echo " $LED2_POWER_ON_OBJPATH is Asserted"

         elif [ "$power" = "Off" ] && [ "$health" = "Good" ]
         then
              busctl set-property $LED_SERVICE $LED2_POWER_OFF_OBJPATH $LED_INTERFACE $LED_PROPERTY b false
              echo " $LED2_POWER_OFF_OBJPATH is Asserted"

         elif [ "$power" = "On" ] && [ "$health" = "Bad" ]
         then
              busctl set-property $LED_SERVICE $LED2_SYSTEM_ON_OBJPATH $LED_INTERFACE $LED_PROPERTY b true
              echo " $LED2_SYSTEM_ON_OBJPATH is Asserted"

         elif [ "$power" = "Off" ] && [ "$health" = "Bad" ]
         then
              busctl set-property $LED_SERVICE $LED2_SYSTEM_OFF_OBJPATH $LED_INTERFACE $LED_PROPERTY b true
              echo " $LED2_SYSTEM_OFF_OBJPATH is Asserted"

         fi

    elif [ "$position" = "3" ]
    then

         power=$(busctl get-property $POWER_STATUS3_SERVICE $POWER_STATUS3_OBJPATH $POWER_STATUS_INTERFACE $POWER_STATUS_PROPERTY \
              | cut  -d'"' -f2 |  cut -d"." -f6)

         echo "Power status 3 : $power"

         busctl set-property $LED_SERVICE $LED_POWER_OBJPATH $LED_INTERFACE $LED_PROPERTY b false

         health=Good


         if [ "$power" = "On" ] && [ "$health" = "Good" ]
         then
              busctl set-property $LED_SERVICE $LED3_POWER_ON_OBJPATH $LED_INTERFACE $LED_PROPERTY b true
              echo " $LED3_POWER_ON_OBJPATH is Asserted"

         elif [ "$power" = "Off" ] && [ "$health" = "Good" ]
         then
              busctl set-property $LED_SERVICE $LED3_POWER_OFF_OBJPATH $LED_INTERFACE $LED_PROPERTY b false
              echo " $LED3_POWER_OFF_OBJPATH is Asserted"

         elif [ "$power" = "On" ] && [ "$health" = "Bad" ]
         then
              busctl set-property $LED_SERVICE $LED3_SYSTEM_ON_OBJPATH $LED_INTERFACE $LED_PROPERTY b true
              echo " $LED3_SYSTEM_ON_OBJPATH is Asserted"

         elif [ "$power" = "Off" ] && [ "$health" = "Bad" ]
         then
              busctl set-property $LED_SERVICE $LED3_SYSTEM_OFF_OBJPATH $LED_INTERFACE $LED_PROPERTY b true
              echo " $LED3_SYSTEM_OFF_OBJPATH is Asserted"

         fi

    elif [ "$position" = "4" ]
    then

         power=$(busctl get-property $POWER_STATUS4_SERVICE $POWER_STATUS4_OBJPATH $POWER_STATUS_INTERFACE $POWER_STATUS_PROPERTY \
              | cut  -d'"' -f2 |  cut -d"." -f6)

         echo "Power status 4 : $power"

         busctl set-property $LED_SERVICE $LED_POWER_OBJPATH $LED_INTERFACE $LED_PROPERTY b false

         health=Bad

         if [ "$power" = "On" ] && [ "$health" = "Good" ]
         then
              busctl set-property $LED_SERVICE $LED4_POWER_ON_OBJPATH $LED_INTERFACE $LED_PROPERTY b true
              echo " $LED4_POWER_ON_OBJPATH is Asserted"

         elif [ "$power" = "Off" ] && [ "$health" = "Good" ]
         then
              busctl set-property $LED_SERVICE $LED4_POWER_OFF_OBJPATH $LED_INTERFACE $LED_PROPERTY b false
              echo " $LED4_POWER_ON_OBJPATH is Asserted"

         elif [ "$power" = "On" ] && [ "$health" = "Bad" ]
         then
              busctl set-property $LED_SERVICE $LED4_SYSTEM_ON_OBJPATH $LED_INTERFACE $LED_PROPERTY b true
              echo " $LED4_SYSTEM_ON_OBJPATH is Asserted"

         elif [ "$power" = "Off" ] && [ "$health" = "Bad" ]
         then
              busctl set-property $LED_SERVICE $LED4_SYSTEM_OFF_OBJPATH $LED_INTERFACE $LED_PROPERTY b true
              echo " $LED4_SYSTEM_OFF_OBJPATH is Asserted"

         fi
    fi
done
