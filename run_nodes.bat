@echo off

set ROS_DOCKER_ADDRESS=%1
if "%ROS_DOCKER_ADDRESS%"=="" (
    echo ROS docker host IP address is expected in the first argument
    exit /b 1
)

set DOCKER_HOST=tcp://%ROS_DOCKER_ADDRESS%:2375
echo Docker Host: %DOCKER_HOST%

docker-compose up -d
exit /b 0
