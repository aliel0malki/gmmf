#!/bin/bash

################################################################################
#  GMMF - General Multi-Purpose File Finder
#  ----------------------------------------
#  Author: Ali El0malki
#  License: MIT License
#  Version: 0.2.0
#
#  Copyright (c) 2024 Ali El0malki
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in all
#  copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#  SOFTWARE.
################################################################################

GREEN="\033[1;32m"
BLUE="\033[1;34m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"
REPO="aliel0malki/gmmf"
BASE_URL="https://github.com/$REPO/releases/latest/download"
echo -e "${BLUE}Detecting your system...${RESET}"
OS=$(uname -s)
ARCH=$(uname -m)
case "$OS" in
  Linux)
    case "$ARCH" in
      x86_64) FILE="gmmf-x86_64-linux.tar.gz" ;;
      aarch64) FILE="gmmf-aarch64-linux.tar.gz" ;;
      *) echo -e "${RED}Unsupported architecture: $ARCH${RESET}"; exit 1 ;;
    esac
    ;;
  Darwin)
    case "$ARCH" in
      x86_64) FILE="gmmf-x86_64-macos.tar.gz" ;;
      arm64) FILE="gmmf-aarch64-macos.tar.gz" ;;
      *) echo -e "${RED}Unsupported architecture: $ARCH${RESET}"; exit 1 ;;
    esac
    ;;
  *)
    echo -e "${RED}Unsupported OS: $OS${RESET}"
    exit 1
    ;;
esac
DOWNLOAD_URL="$BASE_URL/$FILE"
echo -e "${GREEN}Downloading $FILE from the latest release...${RESET}"
curl -L "$DOWNLOAD_URL" -o "$FILE" --progress-bar
if [ $? -ne 0 ]; then
  echo -e "${RED}Failed to download $DOWNLOAD_URL${RESET}"
  exit 1
fi
echo -e "${YELLOW}Extracting files...${RESET}"
mkdir -p gmmf
tar -xzvf "$FILE" -C gmmf
chmod +x gmmf/gmmf
echo -e "${GREEN}Installing...${RESET}"
sudo mv gmmf/gmmf /usr/local/bin/
if [ $? -ne 0 ]; then
  echo -e "${RED}Installation failed. Please try again with sudo.${RESET}"
  exit 1
fi
rm -rf "$FILE" gmmf
echo -e "${GREEN}Installation complete! Run 'gmmf' to get started.${RESET}"
