:i count 12
:b shell 16
./build/bin/gmmf
:i returncode 69
:b stdout 587

[36mGMMF - General Multi-Purpose File Finder[0m

USAGE:

gmmf -g/-f <search term> <directory>

ARGUMENTS:
  -g/-f                      : Mode, '-g' for grep or '-f' for find (default: '-f')
  <search term>              : File name or search string to look for
  <directory>                : Directory to search in

EXAMPLES:
  gmmf -f Documents.txt /home/user
  gmmf -g 'find this text' /home/user

MODES:
  -f (find) (default)        : Search for a file by name
  -g (grep)                 : Search for a string inside files

NOTE: If the [mode] is omitted, the default mode is '-f'

:b stderr 0

:b shell 36
./build/bin/gmmf -f file1 __tests__/
:i returncode 0
:b stdout 156
[1m[33mMode: FIND[0m
[32m[1mFOUND:[0m
    [36m__tests__/dir1/dir2/dir3subsubsubfile1[0m

[1m© 2024 - GMMF (General Multi-Purpose File Finder)[0m

:b stderr 0

:b shell 52
./build/bin/gmmf -f "This is not found" dirnotfound/
:i returncode 1
:b stdout 40
[31m[1mERROR: Directory Not Found[0m

:b stderr 0

:b shell 39
./build/bin/gmmf -f subfile1 __tests__/
:i returncode 0
:b stdout 156
[1m[33mMode: FIND[0m
[32m[1mFOUND:[0m
    [36m__tests__/dir1/dir2/dir3subsubsubfile1[0m

[1m© 2024 - GMMF (General Multi-Purpose File Finder)[0m

:b stderr 0

:b shell 42
./build/bin/gmmf -f subsubfile1 __tests__/
:i returncode 0
:b stdout 156
[1m[33mMode: FIND[0m
[32m[1mFOUND:[0m
    [36m__tests__/dir1/dir2/dir3subsubsubfile1[0m

[1m© 2024 - GMMF (General Multi-Purpose File Finder)[0m

:b stderr 0

:b shell 45
./build/bin/gmmf -f subsubsubfile1 __tests__/
:i returncode 0
:b stdout 156
[1m[33mMode: FIND[0m
[32m[1mFOUND:[0m
    [36m__tests__/dir1/dir2/dir3subsubsubfile1[0m

[1m© 2024 - GMMF (General Multi-Purpose File Finder)[0m

:b stderr 0

:b shell 43
./build/bin/gmmf -f filenotfound __tests__/
:i returncode 1
:b stdout 52
[1m[33mMode: FIND[0m
[31m[1mFile Not Found[0m

:b stderr 0

:b shell 46
./build/bin/gmmf -g "This is file1" __tests__/
:i returncode 0
:b stdout 169
[1m[33mMode: GREP (case-sensitive)[0m
[32m[1mFOUND IN:[0m
    [36m__tests__/file1[0m AT [33m1:1[0m

[1m© 2024 - GMMF (General Multi-Purpose File Finder)[0m

:b stderr 0

:b shell 45
./build/bin/gmmf -g Thisissubfile1 __tests__/
:i returncode 0
:b stdout 176
[1m[33mMode: GREP (case-sensitive)[0m
[32m[1mFOUND IN:[0m
    [36m__tests__/dir1subfile1[0m AT [33m1:1[0m

[1m© 2024 - GMMF (General Multi-Purpose File Finder)[0m

:b stderr 0

:b shell 52
./build/bin/gmmf -g "This is subsubfile1" __tests__/
:i returncode 0
:b stdout 184
[1m[33mMode: GREP (case-sensitive)[0m
[32m[1mFOUND IN:[0m
    [36m__tests__/dir1/dir2subsubfile1[0m AT [33m1:1[0m

[1m© 2024 - GMMF (General Multi-Purpose File Finder)[0m

:b stderr 0

:b shell 51
./build/bin/gmmf -g Thisissubsubsubfile1 __tests__/
:i returncode 0
:b stdout 192
[1m[33mMode: GREP (case-sensitive)[0m
[32m[1mFOUND IN:[0m
    [36m__tests__/dir1/dir2/dir3subsubsubfile1[0m AT [33m1:1[0m

[1m© 2024 - GMMF (General Multi-Purpose File Finder)[0m

:b stderr 0

:b shell 50
./build/bin/gmmf -g "This is not found" __tests__/
:i returncode 1
:b stdout 71
[1m[33mMode: GREP (case-sensitive)[0m
[31m[1mNo Matches Found[0m

:b stderr 0

