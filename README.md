Batch files for building RAD Studio projects
============================================

build.bat
---------

Script to build a project.

  - %1 - path to .*proj file
  - %2 - (opt) project properties (`Project\PropertyGroup` items, separated by ";").
  	* Config=`Release`|`Debug`|...
  	* Platform=`Win32`|`Win64`|...
  If omitted, properties from proj file will be used.
  - %3 - (opt) defines separated by ";"

buildandrun.bat
---------------

Script to build a project and run it. Previous binary is deleted before building and binaries built by the script are deleted after execution. The script runs build and execution in silent mode but in case of error repeats in verbose mode.

  - %1 - full path to project file
  - %2 - config (`Debug`|`Release`|...)
  - %3 - platform (`Win32`|`Win64`|...)
  - %4 - (opt) defines
  - %5 - (opt) binary output path, default: .\ (near proj)

