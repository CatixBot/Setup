@echo off

set ROS_MASTER_ADDRESS=%1
if "%ROS_MASTER_ADDRESS%"=="" (
    echo ROS master IP address is expected in the first argument
    exit /b 1
)

set ROS_CLIENT_ADDRESS=%2
if "%ROS_CLIENT_ADDRESS%"=="" (
    echo ROS client IP address is expected in the second argument
    exit /b 1
)

set DOCKER_HOST=tcp://%ROS_CLIENT_ADDRESS%:2375
echo Docker Host: %DOCKER_HOST%

docker build -t servo-node .
docker run --rm -dit --log-opt max-size=10m --network host -e ROS_MASTER_URI=http://%ROS_MASTER_ADDRESS%:11311 -e ROS_IP=%ROS_MASTER_ADDRESS% --name servo_node --device /dev/i2c-1 servo-node rosrun servo_node ServoNode

exit /b 0
