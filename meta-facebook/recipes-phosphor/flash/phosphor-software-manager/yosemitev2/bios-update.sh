#!/bin/bash

# Exit immediately if a command exits with a non-zero status                           
set -e                                                                                 
                                                                                       
# Get the Slot_id and the bin file path                                            
SLOT_ID=$2    
FUN=$3
CMD_ID=$4    

if [ "$SLOT_ID" = "host1" ]; then
    SLOT_NUM=1
    POWER_CMD_OFF="busctl set-property xyz.openbmc_project.State.Chassis1 /xyz/openbmc_project/state/chassis1 xyz.openbmc_project.State.Chassis RequestedPowerTransition s xyz.openbmc_project.State.Chassis.Transition.Off"
    POWER_CMD_ON="busctl set-property xyz.openbmc_project.State.Chassis1 /xyz/openbmc_project/state/chassis1 xyz.openbmc_project.State.Chassis RequestedPowerTransition s xyz.openbmc_project.State.Chassis.Transition.On" 
elif [ "$SLOT_ID" = "host2" ]; then
    SLOT_NUM=2
    POWER_CMD_OFF="busctl set-property xyz.openbmc_project.State.Chassis2 /xyz/openbmc_project/state/chassis2 xyz.openbmc_project.State.Chassis RequestedPowerTransition s xyz.openbmc_project.State.Chassis.Transition.Off" 
    POWER_CMD_ON="busctl set-property xyz.openbmc_project.State.Chassis2 /xyz/openbmc_project/state/chassis2 xyz.openbmc_project.State.Chassis RequestedPowerTransition s xyz.openbmc_project.State.Chassis.Transition.On" 
elif [ "$SLOT_ID" = "host3" ]; then
    SLOT_NUM=3
    POWER_CMD_OFF="busctl set-property xyz.openbmc_project.State.Chassis3 /xyz/openbmc_project/state/chassis3 xyz.openbmc_project.State.Chassis RequestedPowerTransition s xyz.openbmc_project.State.Chassis.Transition.Off"
    POWER_CMD_ON="busctl set-property xyz.openbmc_project.State.Chassis3 /xyz/openbmc_project/state/chassis3 xyz.openbmc_project.State.Chassis RequestedPowerTransition s xyz.openbmc_project.State.Chassis.Transition.On" 
elif [ "$SLOT_ID" = "host4" ]; then
    SLOT_NUM=4
    POWER_CMD_OFF="busctl set-property xyz.openbmc_project.State.Chassis4 /xyz/openbmc_project/state/chassis4 xyz.openbmc_project.State.Chassis RequestedPowerTransition s xyz.openbmc_project.State.Chassis.Transition.Off"
    POWER_CMD_ON="busctl set-property xyz.openbmc_project.State.Chassis4 /xyz/openbmc_project/state/chassis4 xyz.openbmc_project.State.Chassis RequestedPowerTransition s xyz.openbmc_project.State.Chassis.Transition.On" 
fi

if [ "$CMD_ID" = "bios" ]; then
    BIN_FILE_PATH=$1/bios.bin
elif [ "$CMD_ID" = "cpld" ]; then
    BIN_FILE_PATH=$1/cpld.bin
elif [ "$CMD_ID" = "bic" ]; then
    BIN_FILE_PATH=$1/bic.bin
elif [ "$CMD_ID" = "bicbtl" ]; then
    BIN_FILE_PATH=$1/bicbtl.bin
elif [ "$CMD_ID" = "vr" ]; then
    BIN_FILE_PATH=$1/vr.bin
fi
                                                                                       
# Power-off the slot                                                                  
echo "Power-Off the slot#"$SLOT_NUM                
$POWER_CMD_OFF                                                         
       
sleep 2 
                                                    
# Write firmware 
oem-firmware-update $BIN_FILE_PATH $SLOT_ID $FUN $CMD_ID

# Power on the slot
echo "Power-on the slot#"$SLOT_NUM
$POWER_CMD_ON

sleep 2
