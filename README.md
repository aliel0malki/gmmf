<p align="center">  
  <a href="https://github.com/aliel0malki/gmmf">  
    <img src="https://github.com/aliel0malki/gmmf/blob/main/assets/logo.png" alt="GMMF Logo" width="50" />  
  </a>  
</p>  


> **1.0.0**  


# Motivation
well.. everytime i want to use `find` or `grep` commands, i forgot how to use them. so i made my own.

### **Key Features:**  
- Lightning-fast file search.  
- Find a file by name or part of its name.
- Search within files for a specific string.
- Ability to exclude specific directories.  
- Regular expression-based search (coming soon!).  

---

## **Installation**  

### **Auto Installation**  
Run the following command to install GMMF:  
```bash  
curl -fsSL https://raw.githubusercontent.com/aliel0malki/gmmf/main/scripts/install.sh | bash  
```  

### **Building from Source**  
1. Clone the repository:  
   ```bash  
   git clone https://github.com/aliel0malki/gmmf.git  
   cd gmmf  
   ```  
2. Build and install:  
   ```bash  
   make  
   sudo make install  
   ```  

### **Downloading Pre-Built Binaries**  
Download binaries from the [Releases Page](https://github.com/aliel0malki/gmmf/releases):  
1. Visit the [releases page](https://github.com/aliel0malki/gmmf/releases).  
2. Download the binary for your platform (e.g., `aarch64-linux`, `x86_64-linux`).  

---

## **Usage**  

Run GMMF from your terminal using the format below:  
```bash  
gmmf <mode> <search string> <directory> [options]  
```  

### **Modes:**  
- `-f`: Search for a file by name.  
- `-g`: Search for a string inside files.  

### **Options:**  
- `-ex=<directory>`: Exclude specific directories from the search.  

### **Examples:**  
- Find a file:  
  ```bash  
  gmmf -f documents.txt /home/user  
  ```  
- Search within files:  
  ```bash  
  gmmf -g "search text" /home/user  
  ```  
- Exclude a director(y/ies):  
  ```bash  
  gmmf -g "search text" /home/user -ex=workspace -ex=dont-touch
  ```  

---

## **License**  
Distributed under the MIT License. See the `LICENSE` file for details.
