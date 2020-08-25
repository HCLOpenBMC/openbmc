#!/bin/sh
# Toggle the state of identify LED Group

SERVICE="xyz.openbmc_project.Gpio.Monitor"
OBJECT="xyz/openbmc_project/Gpio/Monitor"
INTERFACE="xyz.openbmc_project.Gpio.Monitor"
PROPERTY="PowerGood4Asserted"

# Get current state
state=$(busctl get-property $SERVICE $OBJECT $INTERFACE $PROPERTY \
	  |  awk '{print $NF;}')

if [ "$state" == "false" ]; then
    target='true'
else
    target='false'
fi

# Set target state
busctl set-property $SERVICE $object $INTERFACE $PROPERTY b $target
