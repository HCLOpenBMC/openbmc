#!/bin/sh
# Set the phoshpor-buttons Positions property

SERVICE="xyz.openbmc_project.Chassis.Buttons"
OBJECT="/xyz/openbmc_project/Chassis/Buttons/Selector0"
INTERFACE="xyz.openbmc_project.Chassis.Buttons.Selector"
PROPERTY="Position"

target=0
# Get current state

state1=$(gpioget 0 212)
state2=$(gpioget 0 213)
state3=$(gpioget 0 214)
state4=$(gpioget 0 215)

target=$(($target+$state1*1))
target=$(($target+$state2*2))
target=$(($target+$state3*4))
target=$(($target+$state4*8))
target=$(($target+1))

if [ $target -eq 6 ] || [ $target -eq 1 ]
then
 tmp=1
  echo  "SW Position : [Host1]...."

elif [ $target -eq 7 ] || [ $target -eq 2 ]
then
 tmp=2
 echo  "SW Position : [Host2]...."

elif [ $target -eq 8 ] || [ $target -eq 3 ]
then
 tmp=3
 echo  "SW Position : [Host3]...."

elif [ $target -eq 9 ] || [ $target -eq 4 ]
then
 tmp=4
 echo  "SW Position : [Host4]...." 

elif [ $target -eq 10 ] || [ $target -eq 5 ]
then
 tmp=5
 echo  "SW Position : [BMC]...."

fi

echo  "Position : $target"
echo  "tmp : $tmp"

sleep 3

# Set target state
busctl set-property $SERVICE $OBJECT $INTERFACE $PROPERTY q $tmp
