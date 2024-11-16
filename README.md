<p align="center">
  <a href="https://github.com/aliel0malki/gmmf">
    <img src="https://github.com/aliel0malki/gmmf/blob/main/assets/logo.png" alt="GMMF Logo" width="50" />
  </a>
</p>

**GMMF - General Multi-Purpose File Finder**

> version 0.69.0


## Features
- Quickly find files
- Word-based search
- Grep-like search inside files
- Exclude directories
- Recursive search
- Support for hidden files
- Regular expression-based search (coming soon)
- Blazingly fast performance


## Installation

### Install Script

```bash
curl -fsSL https://raw.githubusercontent.com/aliel0malki/gmmf/main/install.sh | bash
```

### From Source Code
To build `GMMF` from source:

```bash
git clone https://github.com/aliel0malki/gmmf.git
cd gmmf
make
sudo make install
```

### From Releases
Download a pre-built binary for your platform from the [releases page](https://github.com/aliel0malki/gmmf/releases).

1. Go to the [releases page](https://github.com/aliel0malki/gmmf/releases).
2. Download the binary matching your platform (e.g., `aarch64-linux`, `x86_64-linux`).


## Usage
To use `GMMF`, run it from your terminal with the following format:

```bash
gmmf <mode> <search string> <directory> [options]
```

### Modes:
- `-f`: Search for a word in files.
- `-g`: Search for a string inside files (grep-like search).

### Options:
- `-ex=`: Exclude directories.

### Examples:
```bash
gmmf -f documents.txt /home/user
gmmf -g "find this text" /home/user
gmmf -g "find this text" /home/user -ex=workspace
```


## License
Distributed under the MIT License. See `LICENSE` for more information.
