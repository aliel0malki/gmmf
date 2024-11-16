#!/bin/bash
mkdir -p __tests__/dir1/dir2/dir3
touch __tests__/file1
touch __tests__/dir1/subfile1
touch __tests__/dir1/dir2/subsubfile1
touch __tests__/dir1/dir2/dir3/subsubsubfile1
echo "This is file1" > __tests__/file1
echo "Thisissubfile1" > __tests__/dir1/subfile1
echo "This is subsubfile1" > __tests__/dir1/dir2/subsubfile1
echo "Thisissubsubsubfile1" > __tests__/dir1/dir2/dir3/subsubsubfile1
