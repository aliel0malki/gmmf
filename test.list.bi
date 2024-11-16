:i count 14
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

:b shell 36
./build/bin/gmmf -f file1 __tests__/
:i returncode 0
:b stdout 84
[1m[33mMode: FIND[0m

[1m© 2024 - GMMF (General Multi-Purpose File Finder)[0m

:b stderr 0

:b shell 52
./build/bin/gmmf -f "This is not found" dirnotfound/
:i returncode 1
:b stdout 0

:b stderr 40
[31m[1mERROR: Directory Not Found[0m

:b shell 36
./build/bin/gmmf -f file2 __tests__/
:i returncode 1
:b stdout 106
[1m[33mMode: FIND[0m
[32m[1mFOUND:[0m
    [36m__tests__/dir1/file2[0m
[31m[1mFile Not Found[0m

:b stderr 0

:b shell 36
./build/bin/gmmf -f file3 __tests__/
:i returncode 1
:b stdout 106
[1m[33mMode: FIND[0m
[32m[1mFOUND:[0m
    [36m__tests__/dir1/file3[0m
[31m[1mFile Not Found[0m

:b stderr 0

:b shell 36
./build/bin/gmmf -f file5 __tests__/
:i returncode 1
:b stdout 145
[1m[33mMode: FIND[0m
[32m[1mFOUND:[0m
    [36m__tests__/dir1/dir2/file5[0m
    [36m__tests__/dir1/file5[0m
[31m[1mFile Not Found[0m

:b stderr 0

:b shell 36
./build/bin/gmmf -f file6 __tests__/
:i returncode 1
:b stdout 111
[1m[33mMode: FIND[0m
[32m[1mFOUND:[0m
    [36m__tests__/dir1/dir2/file6[0m
[31m[1mFile Not Found[0m

:b stderr 0

:b shell 43
./build/bin/gmmf -f filenotfound __tests__/
:i returncode 1
:b stdout 52
[1m[33mMode: FIND[0m
[31m[1mFile Not Found[0m

:b stderr 0

:b shell 49
./build/bin/gmmf -g "this is a file 2" __tests__/
:i returncode 1
:b stdout 94
[1m[33mMode: GREP (case-sensitive)[0m
[32m[1mFOUND IN:[0m
[31m[1mNo Matches Found[0m

:b stderr 0

:b shell 47
./build/bin/gmmf -g "this is file 5" __tests__/
:i returncode 1
:b stdout 149
[1m[33mMode: GREP (case-sensitive)[0m
[32m[1mFOUND IN:[0m
    [36m__tests__/dir1/dir2/file5[0m AT [33m1:0[0m
[31m[1mNo Matches Found[0m

:b stderr 0

:b shell 36
./build/bin/gmmf -g file6 __tests__/
:i returncode 1
:b stdout 149
[1m[33mMode: GREP (case-sensitive)[0m
[32m[1mFOUND IN:[0m
    [36m__tests__/dir1/dir2/file6[0m AT [33m1:0[0m
[31m[1mNo Matches Found[0m

:b stderr 0

:b shell 47
./build/bin/gmmf -g "grep not found" __tests__/
:i returncode 1
:b stdout 71
[1m[33mMode: GREP (case-sensitive)[0m
[31m[1mNo Matches Found[0m

:b stderr 0

:b shell 51
./build/bin/gmmf -x "invalidmode" "term" __tests__/
:i returncode 1
:b stdout 0

:b stderr 40
[31m[1mERROR: Directory Not Found[0m

:b shell 65
./build/bin/gmmf -g "file6" . -ex=.github -ex=.git -ex=.zig-cache
:i returncode 0
:b stdout 589
[1m[33mMode: GREP (case-sensitive)[0m
[32m[1mFOUND IN:[0m
    [36m./test.list[0m AT [33m7:20[0m
    [36m./test.list[0m AT [33m11:20[0m
    [36m./test.list[0m AT [33m14:21[0m
    [36m./__tests__/dir1/dir2/file6[0m AT [33m1:0[0m
    [36m./test.list.bi[0m AT [33m84:20[0m
    [36m./test.list.bi[0m AT [33m89:29[0m
    [36m./test.list.bi[0m AT [33m125:20[0m
    [36m./test.list.bi[0m AT [33m130:29[0m
    [36m./test.list.bi[0m AT [33m153:21[0m
    [36m./test.list.bi[0m AT [33m161:31[0m

[1m© 2024 - GMMF (General Multi-Purpose File Finder)[0m

:b stderr 0

