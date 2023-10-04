ip link set can0 down
ip link set can0 type can bitrate 250000 triple-sampling on loopback off
ip link set can0 up 

ip link set can1 down
ip link set can1 type can bitrate 250000 triple-sampling on loopback off
ip link set can1 up 

cansend can0 120#AABBCCDDEEFFFFFF
candump any
