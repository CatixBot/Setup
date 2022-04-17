# 🚀 Getting started guide

This guide walks through the process of building instance of [**CatixBot**](https://github.com/CatixBot) - very simple 4-legged robot for your experiments with kinematics 🦾 and computer vision 📷 (_the project is under development_)

## Electronic components

1. Raspberry Pi equipped with Wi-Fi interface ([Raspberry Pi 3B or better](https://en.wikipedia.org/wiki/Raspberry_Pi#Model_comparison))
2. Monocular camera compatible with Raspberry Pi (fisheye lenses are better for obstacle avoidance)
2. 8x MG90S servos
3. PCA9685 16-channel driver
5. MPU9250 IMU module 
6. 2x voltage regulators to power up separately:
    - PCA9685 connected with 8x servos
    - Raspberry Pi and other low current components

## Assemble robot

1. Print all parts provided in [3d-printing-model](https://github.com/CatixBot/3d-printing-model) repository
2. Assemble each part using screws
2. Install all electronic components on the top of the body

## Setup Raspberry Pi


### Install 'Ubuntu Server'

_It is convenient to set up separate Wi-Fi network first. Then, in any place where such a network will be deployed, robots are always guaranteed to share the same environment without additional settings_

1. Insert SD card (at least 16Gb is recommended)
2. Install [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
3. Open the installed application and select 'Ubuntu Server 20.04.3' 64-bit to be installed    
![alt text](Images/1.png)
4. Write the image
5. Download [user-data](https://github.com/CatixBot/Setup/blob/main/Headless/user-data) and [network-config](https://github.com/CatixBot/Setup/blob/main/Headless/network-config)
5. Update hostname in [user-data](https://github.com/CatixBot/Setup/tree/main/Headless), where '01' should be replaced by 'serial number' of your robot
6. Configure Wi-Fi network credentials in [network-config](https://github.com/CatixBot/Setup/blob/main/Headless/network-config) to which the robot will connect to
7. Replace both files in the root of 'system-boot' partition on SD card

---

### Setup host

1. Install the latest version of [VS Code](https://code.visualstudio.com/)
2. Add [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) extension set
3. Add [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) extension
4. Set the value of `DOCKER_HOST` variable in 'Docker' extension settings: `tcp://<docker-host>:2375`, where '\<docker-host\>' is your 'Raspberry Pi' with a docker daemon running
    
_After this step, you can connect to the 'Raspberry Pi' via SSH (user: catix, password: catix) using [Remote-SSH](https://code.visualstudio.com/docs/remote/ssh) extension to follow the next steps_

---

### Setup docker

1. Clone this repository and run the setup script
    ```
    $ git clone https://github.com/CatixBot/getting-started-guide.git && cd getting-started-guide
    $ chmod +x ./setup.sh && sudo ./setup.sh
    ```
2. Restart for the settings to take effect
    ```
    $ sudo reboot
    ```
3. Check that the docker daemon is running
    ```
    $ systemctl status docker
    ```
4. If the daemon has 'failed' status, it is possible to print its launching logs to figure out the reason
    ```
    $ journalctl -fu docker
    ```
5. Check whether docker has been set up correctly by running 'hello-world' image
    ```
    $ docker run hello-world
    ```
6. Go to the 'Docker' tab in VS Code, which contains a list of robot's ROS2 nodes (docker images and containers)

    ### _Finally, it is possible to manage ROS/ROS2 nodes as docker containers_
