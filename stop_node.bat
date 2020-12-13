@echo off

set ROS_CLIENT_ADDRESS=%1
if "%ROS_CLIENT_ADDRESS%"=="" (
    echo ROS client IP address is expected in the first argument
    exit /b 1
)

set DOCKER_HOST=tcp://%ROS_CLIENT_ADDRESS%:2375
echo Docker Host: %DOCKER_HOST%

docker stop servo_node
