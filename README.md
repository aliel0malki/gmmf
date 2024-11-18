<p align="center">  
  <a href="https://github.com/aliel0malki/gmmf">  
    <img src="https://github.com/aliel0malki/gmmf/blob/main/assets/logo.png" alt="GMMF Logo" width="50" />  
  </a>  
</p>  

# **GMMF - General Multi-Purpose File Finder**  
> **0.70.0**  

## **Overview**  
GMMF is a fast and versatile file finder tool designed to simplify file searching with powerful features and exceptional performance.  

### **Key Features:**  
- Lightning-fast file search.  
- Word-based search for files.  
- Grep-like search inside file contents.  
- Ability to exclude specific directories.  
- Recursive search with support for hidden files.  
- Regular expression-based search (coming soon!).  

---

## **Comparison with Other Tools**  

Below is a comparison of execution times for `GMMF` and `find` command:  

### Commands Tested:  
- `gmmf -f . .`  
- `find`  

| **Metric**    | **GMMF**      | **Find**       |  
|---------------|---------------|---------------|  
| **Real Time** | 0m4.103s      | 0m33.135s     |  
| **User Time** | 0m0.142s      | 0m0.977s      |  
| **System Time** | 0m1.621s     | 0m8.410s      |  

---

## **Installation**  

### **Auto Installation**  
Run the following command to install GMMF:  
```bash  
curl -fsSL https://raw.githubusercontent.com/aliel0malki/gmmf/main/install.sh | bash  
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
