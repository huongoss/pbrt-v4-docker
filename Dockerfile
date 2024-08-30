FROM ubuntu:22.04 as pbrt

ENV DEBIAN_FRONTEND=noninteractive

# Update the package lists
RUN apt-get update -y

# Install any necessary packages for building the application
RUN apt-get install -y build-essential git cmake

# Set the working directory
WORKDIR /app

RUN git clone --recursive https://github.com/huongoss/pbrt-v4-docker.git

# Install any necessary packages for building the application
RUN apt-get install -y libglu1-mesa-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev libxxf86vm-dev libxss-dev libxext-dev libx11-dev

# Set the working directory
WORKDIR /app/pbrt-v4

RUN cmake -S . -B build  && \
    cmake --build build -j && \
    cp build/pbrt /usr/local/bin/


# Specify the command to run when the container starts
ENTRYPOINT ["/usr/local/bin/pbrt" ]