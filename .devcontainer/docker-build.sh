#!/usr/bin/env bash
# <h1><code>docker-build.sh</code> - Perform installs during the docker container build process</h1>
# <p>Prevent interactive debconf during installations.</p>
set DEBIAN_FRONTEND=noninteractive

# Install textbook authoring support software: LaTeX, sage, and other pdf tools.
apt update
#apt install -y --no-install-recommends python3-pip texlive texlive-latex-extra texlive-fonts-extra texlive-xetex texlive-science texlive-music sagemath ghostscript pdf2svg

# Upgrade pip and install required Python tools.
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade CodeChat-Server runestone pretext

# Install the GitHub CLI; taken from the [docs](https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian-ubuntu-linux-raspberry-pi-os-apt).
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
