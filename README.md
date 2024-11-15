<p align="center">
  <a href="https://github.com/aliel0malki/gmmf">
    <img src="https://github.com/aliel0malki/gmmf/blob/main/assets/logo.png" alt="GMMF Logo" width="50" />
  </a>
</p>

**GMMF - General Multi-Purpose File Finder**

> v0.2.0


## Features
- Quickly find files
- Word-based search (not implemented yet)
- Regular expression-based search (not implemented yet)
- Support for hidden files
- Recursive search
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
gmmf <directory> <file name>
```

Replace `<directory>` with the directory you want to search in, and `<file_name>` with the name of the file you're looking for.

For example:
```bash
gmmf /home/user documents.txt
```


## License
Distributed under the MIT License. See `LICENSE` for more information.
