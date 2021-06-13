### FindPGE

This find module tries to make it easy to use the Pixel Game Engine in a project with CMake without much need for supporting different platforms on your own.

It also tries to update the previous cmake template for PGE, which was out of date and also placed a lot of aditional code in the CMakeLists.txt file, which here have been moved to the FindPGE.cmake module in order to clean the main file code.

This module will provide a standard interface library for linking that should work with any of the following platforms:
* Windows 10
* Linux (Tested on Mint, Xubuntu 20.04, Fedora 34)

## Adding to an existing project
If you want to add the PGE to your cmake project, you can follow the example given in this repository.

In case you want to add this to your already existing project, these are the commands used to do so.

First, tell cmake where the find module is. This can be done by setting the `CMAKE_MODULE_PATH` variable. In this project, which has the find module inside the `cmake` folder, the command used is:

```cmake
set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${PROJECT_SOURCE_DIR}/cmake")
```
To invoke the find module, just call `find_package` with the package name:

```cmake
find_package(PGE)
```

The final step is to link the libraries to your executable, which can be done this way:

```cmake
target_link_libraries(your_target PRIVATE PGE)
```

In case other targets also use pge, but don't need to link to it, it's possible to use the `PGE_INCLUDE_DIRS` variable to get the directory to the PGE header.

This can be done this way:

```cmake
target_include_directory(your_target PRIVATE ${PGE_INCLUDE_DIRS})
```