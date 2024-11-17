:i count 13
:b shell 16
./build/bin/gmmf
:i returncode 69
:b stdout 630

[36mGMMF - General Multi-Purpose File Finder[0m

USAGE:
  gmmf <mode> <search term> <directory> [options]

ARGUMENTS:
  <mode>                     : Mode to use (find or grep)
  <search term>              : File name or search string to look for
  <directory>                : Directory to search in

MODES:
  -f (find)                 : Search for a file
  -g (grep)                 : Search for a string inside files

OPTIONS:
  -ex=<directory>              : Exclude directories from search

EXAMPLES:
  gmmf -f Documents.txt /home/user
  gmmf -g 'find this text' /home/user
  gmmf -f Documents.txt /home/user -ex=Documents

:b stderr 0

:b shell 52
./build/bin/gmmf -f "This is not found" dirnotfound/
:i returncode 1
:b stdout 0

:b stderr 33
[31m[1mDIRECTORY NOT FOUND[0m

:b shell 36
./build/bin/gmmf -f file2 __tests__/
:i returncode 0
:b stdout 78
[1m[33mMode: FIND[0m
[32m[1mFOUND:[0m
    [36m__tests__/dir1/file2[0m

:b stderr 0

:b shell 36
./build/bin/gmmf -f file3 __tests__/
:i returncode 0
:b stdout 78
[1m[33mMode: FIND[0m
[32m[1mFOUND:[0m
    [36m__tests__/dir1/file3[0m

:b stderr 0

:b shell 36
./build/bin/gmmf -f file5 __tests__/
:i returncode 0
:b stdout 117
[1m[33mMode: FIND[0m
[32m[1mFOUND:[0m
    [36m__tests__/dir1/dir2/file5[0m
    [36m__tests__/dir1/file5[0m

:b stderr 0

:b shell 36
./build/bin/gmmf -f file6 __tests__/
:i returncode 0
:b stdout 83
[1m[33mMode: FIND[0m
[32m[1mFOUND:[0m
    [36m__tests__/dir1/dir2/file6[0m

:b stderr 0

:b shell 43
./build/bin/gmmf -f filenotfound __tests__/
:i returncode 0
:b stdout 44
[1m[33mMode: FIND[0m
[32m[1mFOUND:[0m

:b stderr 0

:b shell 49
./build/bin/gmmf -g "this is a file 2" __tests__/
:i returncode 0
:b stdout 321
[1m[33mMode: GREP (case-sensitive)[0m
[32m[1mFOUND IN:[0m
    [36m__tests__/dir1/file2[0m AT [33m1:0[0m
    [36m__tests__/dir1/file3[0m AT [33m1:0[0m
    [36m__tests__/dir1/file4[0m AT [33m1:0[0m
    [36m__tests__/dir1/file5[0m AT [33m1:0[0m
    [36m__tests__/dir1/dir2-ex/file[0m AT [33m1:0[0m

:b stderr 0

:b shell 47
./build/bin/gmmf -g "this is file 5" __tests__/
:i returncode 0
:b stdout 119
[1m[33mMode: GREP (case-sensitive)[0m
[32m[1mFOUND IN:[0m
    [36m__tests__/dir1/dir2/file5[0m AT [33m1:0[0m

:b stderr 0

:b shell 36
./build/bin/gmmf -g file6 __tests__/
:i returncode 0
:b stdout 119
[1m[33mMode: GREP (case-sensitive)[0m
[32m[1mFOUND IN:[0m
    [36m__tests__/dir1/dir2/file6[0m AT [33m1:0[0m

:b stderr 0

:b shell 47
./build/bin/gmmf -g "grep not found" __tests__/
:i returncode 0
:b stdout 64
[1m[33mMode: GREP (case-sensitive)[0m
[32m[1mFOUND IN:[0m

:b stderr 0

:b shell 51
./build/bin/gmmf -x "invalidmode" "term" __tests__/
:i returncode 1
:b stdout 0

:b stderr 33
[31m[1mDIRECTORY NOT FOUND[0m

:b shell 60
./build/bin/gmmf -g "this is a file 2" __tests__ -ex=dir2-ex
:i returncode 0
:b stdout 264
[1m[33mMode: GREP (case-sensitive)[0m
[32m[1mFOUND IN:[0m
    [36m__tests__/dir1/file2[0m AT [33m1:0[0m
    [36m__tests__/dir1/file3[0m AT [33m1:0[0m
    [36m__tests__/dir1/file4[0m AT [33m1:0[0m
    [36m__tests__/dir1/file5[0m AT [33m1:0[0m

:b stderr 0

