#!/bin/sh
# Set the hand switch position using Misc

SERVICE="xyz.openbmc_project.Misc.Ipmi"
INTERFACE="xyz.openbmc_project.Misc.Ipmi"
object="/xyz/openbmc_project/misc/ipmi"
PROPERTY1="Hand_SW1"
PROPERTY2="Hand_SW2"
PROPERTY3="Hand_SW3"
PROPERTY4="Hand_SW4"
PROPERTY5="Position"

target=0
# Get current state

state1=$(busctl get-property $SERVICE $object $INTERFACE $PROPERTY1 \
          |  awk '{print $NF;}')
echo  "Before setting : $state1"

state2=$(busctl get-property $SERVICE $object $INTERFACE $PROPERTY2 \
           |  awk '{print $NF;}')
echo  "Before setting : $state2"

state3=$(busctl get-property $SERVICE $object $INTERFACE $PROPERTY3 \
           |  awk '{print $NF;}')
echo  "Before setting : $state3"

state4=$(busctl get-property $SERVICE $object $INTERFACE $PROPERTY4 \
           |  awk '{print $NF;}')
echo  "Before setting : $state4"

if [ "$1" = "1" ]
then
        if [ "$state1" = "0" ]
        then
                busctl set-property $SERVICE $object $INTERFACE $PROPERTY1 i 1
        else
                busctl set-property $SERVICE $object $INTERFACE $PROPERTY1 i 0
        fi
elif [ "$1" = "2" ]
then
        if [ "$state2" = "0" ]
        then
                busctl set-property $SERVICE $object $INTERFACE $PROPERTY2 i 1
        else
                busctl set-property $SERVICE $object $INTERFACE $PROPERTY2 i 0
        fi
elif [ "$1" = "3" ]
then
        if [ "$state3" = "0" ]
        then
                busctl set-property $SERVICE $object $INTERFACE $PROPERTY3 i 1
        else
                busctl set-property $SERVICE $object $INTERFACE $PROPERTY3 i 0
        fi
elif [ "$1" = "4" ]
then
        if [ "$state4" = "0" ]
        then
                busctl set-property $SERVICE $object $INTERFACE $PROPERTY4 i 1
        else
                busctl set-property $SERVICE $object $INTERFACE $PROPERTY4 i 0
        fi
fi

state1=$(busctl get-property $SERVICE $object $INTERFACE $PROPERTY1 \
          |  awk '{print $NF;}')
echo  "After setting : $state1"

state2=$(busctl get-property $SERVICE $object $INTERFACE $PROPERTY2 \
           |  awk '{print $NF;}')
echo  "After setting : $state2"

state3=$(busctl get-property $SERVICE $object $INTERFACE $PROPERTY3 \
           |  awk '{print $NF;}')
echo  "After setting : $state3"

state4=$(busctl get-property $SERVICE $object $INTERFACE $PROPERTY4 \
           |  awk '{print $NF;}')
echo  "After setting : $state4"

target=$(($target+$state1*1))
target=$(($target+$state2*2))
target=$(($target+$state3*4))
target=$(($target+$state4*8))
target=$(($target+1))
echo  "Position : $target"

# Set target state
busctl set-property $SERVICE $object $INTERFACE $PROPERTY5 i $target
