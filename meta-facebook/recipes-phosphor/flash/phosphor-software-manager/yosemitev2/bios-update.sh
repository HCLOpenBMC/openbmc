#!/bin/bash

echo "Yosemitev2 bios updated successfully for "$1

# Exit immediately if a command exits with a non-zero status                           
set -e                                                                                 
                                                                                       
# Initialise variables                                                                 
POWER_CMD="/usr/sbin/power-util "                                                      
                                                                                       
# Get the Slot_id and the bin file path                                            
SLOT_ID=$2    
FUN=$3
CMD_ID=$4    

if [ "$SLOT_ID" = "host1" ]; then
   SLOT_NUM=1
elif [ "$SLOT_ID" = "host2" ]; then
	SLOT_NUM=2
elif [ "$SLOT_ID" = "host3" ]; then
	SLOT_NUM=3
elif [ "$SLOT_ID" = "host4" ]; then
	SLOT_NUM=4
fi

if [ "$CMD_ID" = "bios" ]; then
    BIN_FILE_PATH=$1/bios.bin
elif [ "$CMD_ID" = "cpld" ]; then
    BIN_FILE_PATH=$1/cpld.bin
fi
                                                                                       
# Power-off the slot                                                                  
echo "Power-Off the slot#"$SLOT_NUM                
$POWER_CMD $SLOT_NUM off                                                          
                                                           
# Check whether the slot is in Off condition                                     
if [[ $($POWER_CMD $SLOT_NUM status) != *"off"* ]];                                   
then                                                                             
    echo "Power-Off Didn't occur in slot#"$SLOT_NUM
    echo "Bios upgrade failed"                                                   
    exit -1                                                                      
fi                                                                                
echo "Powered-Off Slot#"$SLOT_NUM 

# Write firmware 
fb-yv2-misc $BIN_FILE_PATH $SLOT_ID $FUN $CMD_ID

# Power on the slot
echo "Power-on the slot#"$SLOT_NUM
$POWER_CMD $SLOT_NUM on

# Check whether the slot is in On condition                                     
if [[ $($POWER_CMD $SLOT_NUM status) != *"on"* ]];                                   
then                                                                             
    echo "Failed to power-On slot#"$SLOT_NUM
    echo "Bios upgrade failed"                                                   
    exit -1                                                                      
fi                                                                                
echo "Powered-On Slot#"$SLOT_NUM


