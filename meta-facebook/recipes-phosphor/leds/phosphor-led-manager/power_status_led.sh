#!/bin/sh

#POWER_STATUS_SERVICE="xyz.openbmc_project.State.Chassis$1"
#POWER_STATUS_OBJPATH="/xyz/openbmc_project/state/chassis$1"
#POWER_STATUS_INTERFACE="xyz.openbmc_project.State.Chassis"
#POWER_STATUS_PROPERTY="CurrentPowerState"

POWER_STATUS1_SERVICE="xyz.openbmc_project.State.Chassis1"
POWER_STATUS1_OBJPATH="/xyz/openbmc_project/state/chassis1"
POWER_STATUS1_INTERFACE="xyz.openbmc_project.State.Chassis"
POWER_STATUS1_PROPERTY="CurrentPowerState"

POWER_STATUS2_SERVICE="xyz.openbmc_project.State.Chassis2"
POWER_STATUS2_OBJPATH="/xyz/openbmc_project/state/chassis2"
POWER_STATUS2_INTERFACE="xyz.openbmc_project.State.Chassis"
POWER_STATUS2_PROPERTY="CurrentPowerState"

POWER_STATUS3_SERVICE="xyz.openbmc_project.State.Chassis3"
POWER_STATUS3_OBJPATH="/xyz/openbmc_project/state/chassis3"
POWER_STATUS3_INTERFACE="xyz.openbmc_project.State.Chassis"
POWER_STATUS3_PROPERTY="CurrentPowerState"

POWER_STATUS4_SERVICE="xyz.openbmc_project.State.Chassis4"
POWER_STATUS4_OBJPATH="/xyz/openbmc_project/state/chassis4"
POWER_STATUS4_INTERFACE="xyz.openbmc_project.State.Chassis"
POWER_STATUS4_PROPERTY="CurrentPowerState"

LED_SERVICE="xyz.openbmc_project.LED.GroupManager"
LED_POWER_OBJPATH="/xyz/openbmc_project/led/groups/power_led"
LED_POWER1_OBJPATH="/xyz/openbmc_project/led/groups/power1_led"
LED_POWER2_OBJPATH="/xyz/openbmc_project/led/groups/power2_led"
LED_POWER3_OBJPATH="/xyz/openbmc_project/led/groups/power3_led"
LED_POWER4_OBJPATH="/xyz/openbmc_project/led/groups/power4_led"

LED_SYSTEM_OBJPATH="/xyz/openbmc_project/led/groups/system_led"
LED_SYSTEM1_OBJPATH="/xyz/openbmc_project/led/groups/system1_led"
LED_SYSTEM2_OBJPATH="/xyz/openbmc_project/led/groups/system2_led"
LED_SYSTEM3_OBJPATH="/xyz/openbmc_project/led/groups/system3_led"
LED_SYSTEM4_OBJPATH="/xyz/openbmc_project/led/groups/system4_led"

LED_INTERFACE="xyz.openbmc_project.Led.Group"
LED_PROPERTY="Asserted"

KNOB_SELECTOR_SERVICE="xyz.openbmc_project.Chassis.Buttons"
KNOB_SELECTOR_OBJPATH="/xyz/openbmc_project/Chassis/Buttons/Selector0"
KNOB_SELECTOR_INTERFACE="xyz.openbmc_project.Chassis.Buttons.Selector"
KNOB_SELECTOR_PROPERTY="Position"

while true; do

    position=$(busctl get-property $KNOB_SELECTOR_SERVICE $KNOB_SELECTOR_OBJPATH $KNOB_SELECTOR_INTERFACE $KNOB_SELECTOR_PROPERTY \
              |  awk '{print $NF;}')

    echo "Knob Position : $position"

    if [ "$position" = "5" ]
    then
         busctl set-property $LED_SERVICE $LED_POWER_OBJPATH $LED_INTERFACE $LED_PROPERTY b true

         echo " $LED_POWER_OBJPATH is Asserted"

         busctl set-property $LED_SERVICE $LED_POWER1_OBJPATH $LED_INTERFACE $LED_PROPERTY b false
         busctl set-property $LED_SERVICE $LED_POWER2_OBJPATH $LED_INTERFACE $LED_PROPERTY b false
         busctl set-property $LED_SERVICE $LED_POWER3_OBJPATH $LED_INTERFACE $LED_PROPERTY b false
         busctl set-property $LED_SERVICE $LED_POWER4_OBJPATH $LED_INTERFACE $LED_PROPERTY b false

    elif [ "$position" = "1" ]
    then

         power=$(busctl get-property $POWER_STATUS1_SERVICE $POWER_STATUS1_OBJPATH $POWER_STATUS1_INTERFACE $POWER_STATUS1_PROPERTY \
              |  cut -d"." -f6)

         echo "Power status 1 : $power"

         busctl set-property $LED_SERVICE $LED_POWER_OBJPATH $LED_INTERFACE $LED_PROPERTY b false

         health=Good

         if [ "$power" = "On" ] && [ "$health" = "Good" ]
         then 
              busctl set-property $LED_SERVICE $LED_POWER1_OBJPATH $LED_INTERFACE $LED_PROPERTY b true
              echo " $LED_POWER1_OBJPATH is Asserted"

         elif [ "$power" = "Off" ] && [ "$health" = "Good" ]
         then
              busctl set-property $LED_SERVICE $LED_POWER1_OBJPATH $LED_INTERFACE $LED_PROPERTY b false
              echo " $LED_POWER1_OBJPATH is DeAsserted"

          fi

    elif [ "$position" = "2" ]
    then

         power=$(busctl get-property $POWER_STATUS2_SERVICE $POWER_STATUS2_OBJPATH $POWER_STATUS2_INTERFACE $POWER_STATUS2_PROPERTY \
              |  cut -d"." -f6)

         echo "Power status 2 : $power"

         busctl set-property $LED_SERVICE $LED_POWER_OBJPATH $LED_INTERFACE $LED_PROPERTY b false

         health=Good

         if [ "$power" = "On" ] && [ "$health" = "Good" ]
         then
              busctl set-property $LED_SERVICE $LED_POWER2_OBJPATH $LED_INTERFACE $LED_PROPERTY b true
              echo " $LED_POWER2_OBJPATH is Asserted"

         elif [ "$power" = "Off" ] && [ "$health" = "Good" ]
         then
              busctl set-property $LED_SERVICE $LED_POWER2_OBJPATH $LED_INTERFACE $LED_PROPERTY b false
              echo " $LED_POWER2_OBJPATH is DeAsserted"

         fi

    elif [ "$position" = "3" ]
    then

         power=$(busctl get-property $POWER_STATUS3_SERVICE $POWER_STATUS3_OBJPATH $POWER_STATUS3_INTERFACE $POWER_STATUS3_PROPERTY \
              |  cut -d"." -f6)

         echo "Power status 3 : $power"

         busctl set-property $LED_SERVICE $LED_POWER_OBJPATH $LED_INTERFACE $LED_PROPERTY b false

         health=Good

         if [ "$power" = "On" ] && [ "$health" = "Good" ]
         then
              busctl set-property $LED_SERVICE $LED_POWER3_OBJPATH $LED_INTERFACE $LED_PROPERTY b true
              echo " $LED_POWER3_OBJPATH is Asserted"

         elif [ "$power" = "Off" ] && [ "$health" = "Good" ]
         then

              busctl set-property $LED_SERVICE $LED_POWER3_OBJPATH $LED_INTERFACE $LED_PROPERTY b false
              echo " $LED_POWER3_OBJPATH is DeAsserted"

         fi

    elif [ "$position" = "4" ]
    then

         power=$(busctl get-property $POWER_STATUS4_SERVICE $POWER_STATUS4_OBJPATH $POWER_STATUS4_INTERFACE $POWER_STATUS4_PROPERTY \
              |  cut -d"." -f6)

         echo "Power status 4 : $power"

         busctl set-property $LED_SERVICE $LED_POWER_OBJPATH $LED_INTERFACE $LED_PROPERTY b false

         health=Good

         if [ "$power" = "On" ] && [ "$health" = "Good" ]
         then
              busctl set-property $LED_SERVICE $LED_POWER4_OBJPATH $LED_INTERFACE $LED_PROPERTY b true
              echo " $LED_POWER4_OBJPATH is Asserted"

         elif [ "$power" = "Off" ] && [ "$health" = "Good" ]
         then
              busctl set-property $LED_SERVICE $LED_POWER4_OBJPATH $LED_INTERFACE $LED_PROPERTY b false
              echo " $LED_POWER4_OBJPATH is DeAsserted"

         fi
    fi
done
