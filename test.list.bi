:i count 6
:b shell 16
./build/bin/gmmf
:i returncode 69
:b stdout 110
[1m[36mGMMF - General Multi-Purpose File Finder[0m

[1mUSAGE:[33m
	[36mgmmf <directory> <file name>[0m

:b stderr 0

:b shell 33
./build/bin/gmmf __tests__/ file1
:i returncode 0
:b stdout 102
[1m[32mFOUND: [36m__tests__//file1[0m

[1m© 2024 - GMMF (General Multi-Purpose File Finder)[0m

:b stderr 0

:b shell 36
./build/bin/gmmf __tests__/ subfile1
:i returncode 0
:b stdout 109
[1m[32mFOUND: [36m__tests__/dir1/subfile1[0m

[1m© 2024 - GMMF (General Multi-Purpose File Finder)[0m

:b stderr 0

:b shell 39
./build/bin/gmmf __tests__/ subsubfile1
:i returncode 0
:b stdout 117
[1m[32mFOUND: [36m__tests__/dir1/dir2/subsubfile1[0m

[1m© 2024 - GMMF (General Multi-Purpose File Finder)[0m

:b stderr 0

:b shell 42
./build/bin/gmmf __tests__/ subsubsubfile1
:i returncode 0
:b stdout 125
[1m[32mFOUND: [36m__tests__/dir1/dir2/dir3/subsubsubfile1[0m

[1m© 2024 - GMMF (General Multi-Purpose File Finder)[0m

:b stderr 0

:b shell 41
./build/bin/gmmf __tests__/ filenotfound1
:i returncode 1
:b stdout 88
[31m[1mFile Not Found[0m

[1m© 2024 - GMMF (General Multi-Purpose File Finder)[0m

:b stderr 0

