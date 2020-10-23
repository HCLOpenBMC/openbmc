#!/bin/bash

echo "Yosemitev2 bios updated successfully for "$1

# Exit immediately if a command exits with a non-zero status                           
set -e                                                                                 
                                                                                       
# Initialise variables                                                                 
POWER_CMD="/usr/sbin/power-util "                                                      
                                                                                       
# Get the Slot_id and the bin file path                                            
SLOT_ID=$1                                                                              
BIN_FILE_PATH=$2/bios.bin                                                                       
                                                                                  
# Check whether the slot is not empty                                                  
                                                                                       
# Power-off the slot                                                                  
echo "Power-Off the slot#"$SLOT_ID                
$POWER_CMD $SLOT_ID off                                                          
#sleep 5                                                    
                                                           
# Check whether the slot is in Off condition                                     
if [[ $($POWER_CMD $SLOT_ID status) != *"off"* ]];                                   
then                                                                             
    echo "Power-Off Didn't occur in slot#"$SLOT_ID
    echo "Bios upgrade failed"                                                   
    exit -1                                                                      
fi                                                                                
echo "Powered-Off Slot#"$SLOT_ID 

fb-yv2-misc $BIN_FILE_PATH $SLOT_ID

# Power on the slot
echo "Power-on the slot#"$SLOT_ID
$POWER_CMD $SLOT_ID on

# Check whether the slot is in On condition                                     
if [[ $($POWER_CMD $SLOT_ID status) != *"on"* ]];                                   
then                                                                             
    echo "Failed to power-On slot#"$SLOT_ID
    echo "Bios upgrade failed"                                                   
    exit -1                                                                      
fi                                                                                
echo "Powered-On Slot#"$SLOT_ID 


