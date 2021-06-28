## Setup 'Raspberry Pi'

_Before installing the OS, it is convenient to set up separate Wi-Fi network, where SSID and password can be, for example - 'CatixNetwork'. Then, in any place where such a network will be deployed, robots are always guaranteed to share the same environment without of additional settings_

1. Flash your SD card with the latest ['Ubuntu Server 20.04' image](https://ubuntu.com/download/raspberry-pi). You can use ['balenaEtcher'](https://www.balena.io/etcher/) to do it. Remount your SD card to get access to 'network-config' and 'user-data':
    - Replace any content in 'user-data' with the following:
    ```
    # Set your hostname here, the manage_etc_hosts will update the hosts file entries as well
    hostname: catix-XX
    manage_etc_hosts: true

    # Add users to the system. Users are added after groups are added.
    users:
    - name: catix
        plain_text_passwd: catix
        groups: users,docker,video,i2c
        sudo: ALL=(ALL) NOPASSWD:ALL
        lock_passwd: false

    ## Reboot to enable Wifi configuration (more details in network-config file)
    power_state:
      mode: reboot

    # Enable password authentication with the SSH daemon
    ssh_pwauth: true
    ```
    - There 'catix-XX' should be modified, so 'XX' is the serial number of your robot;
    - Add Wi-Fi network credentials to 'network-config'.

2. [Follow the instruction](https://docs.docker.com/engine/install/ubuntu/) to install 'Docker' daemon to easily deploy ROS2 nodes.
3. Configure the docker daemon for port '2375' listening. To do this, create a [configuration file](https://docs.docker.com/config/daemon/) with the following content:
    ```
    {
         "hosts": ["unix: ///var/run/docker.sock", "tcp://<docker-host>:2375"]
    }
    ```

    _Here 'docker-host' is a hostname or an IP adress of your 'Raspberry Pi'_
4. Restart for the settings to take effect: `sudo shutdown -r now`;
5. [Check](http://docs.docker.oeynet.com/engine/admin/#check-whether-docker-is-running) that the docker daemon is running. It is required for the next steps.

---

## Setup host
1. Install the latest version of [VS Code](https://code.visualstudio.com/);
2. Add the set of extensions for [remote development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack).
3. Add [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) extension:
    - Set the value of 'DOCKER_HOST' variable in the extension settings: `tcp://<docker-host>: 2375`, where 'docker-host' is your 'Raspberry Pi' with a docker daemon running.

    _After this step, you should to connect to the 'Raspberry Pi' via SSH using [Remote-SSH](https://code.visualstudio.com/docs/remote/ssh) extension to get the public connection key._
4. Go to the 'Docker' tab in VS Code, which will contain a list of robot's ROS2 running nodes and available images.
