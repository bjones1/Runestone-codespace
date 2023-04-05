FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install required packages
RUN apt-get update && \
    apt-get install -y python3 python3-pip verilog

# Upgrade pip and install required Python tools
RUN python3 -m pip install --user --upgrade pip && \
    python3 -m pip install --user CodeChat-Server runestone bookserver

#Installing more textbook developing software: LaTeX, sage, and other pdf tools
RUN apt update && \
    echo "Install LaTeX" && \
    apt install -y texlive-full --no-install-recommends && \
    apt install -y fonts-font-awesome --no-install-recommends && \
    echo "Install sage" && \
    apt install -y sagemath --no-install-recommends && \
    echo "Install PDF tools" && \
    apt install -y ghostscript pdf2svg --no-install-recommends
