FROM ros:melodic-robot

RUN apt update && \
	apt upgrade -y

RUN rm -rf /var/lib/apt/lists/

RUN mkdir -p ~/catkin_ws/src/ && \
	cd ~/catkin_ws/src/ && \
	git clone --recursive https://github.com/CatixBot/ServoNode.git

RUN /bin/bash -c " \
	echo 'source /opt/ros/melodic/setup.bash' >> ~/.bashrc && \
	source /opt/ros/melodic/setup.bash && \
	cd ~/catkin_ws/ && \
	catkin_make -j2 && \
	sed -i '/exec/ i source ~/catkin_ws/devel/setup.bash' /ros_entrypoint.sh && \
	echo 'source ~/catkin_ws/devel/setup.bash' >> ~/.bashrc && \
	source ~/catkin_ws/devel/setup.bash && \
	echo Done. \
	"