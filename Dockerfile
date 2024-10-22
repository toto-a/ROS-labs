FROM dorowu/ubuntu-desktop-lxde-vnc:bionic
 
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get install -q -y \
    dirmngr \
    gnupg2 \
    lsb-release \
    vim \
    curl \
    nano\
    gedit\
    wget \
    && rm -rf /var/lib/apt/lists/*
 
RUN apt-get update
 
 
 
#Install gazebo
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
RUN wget https://packages.osrfoundation.org/gazebo.key -O - | apt-key add -
RUN apt-get update
RUN apt-get -y install gazebo9
RUN apt-get -y install libgazebo9-dev
 
 
 
# Install ros melodic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt update
 
RUN apt-get install -y ros-melodic-desktop-full
RUN apt-get install -y ros-melodic-catkin python-catkin-tools
RUN apt-get install -y python3-pip
RUN python3 -m pip install -U rosdep
RUN rosdep init
RUN rosdep update
RUN apt install python-catkin-tools
 
 
#Install packages
RUN apt-get update
RUN apt-get install ros-melodic-gazebo-ros-pkgs ros-melodic-gazebo-ros-control
 
 
## Source bash for ros command
## go home and source
 
RUN mkdir -p ~/catkin_ws/src && cd ~/catkin_ws
WORKDIR /home/catkin_ws
RUN  . /opt/ros/melodic/setup.bash
RUN catkin_make
RUN apt update