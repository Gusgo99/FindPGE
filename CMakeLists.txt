cmake_minimum_required(VERSION "3.10.2")

project("FindPGE")

# Set language version
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Here we tell cmake where to find the modules we'll use. FindPGE.cmake should be in the a directory listed here.
set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${PROJECT_SOURCE_DIR}/cmake")

# Enable unicode.
add_definitions("-DUNICODE")
add_definitions("-D_UNICODE")

# Gives a target that helps in linking the specific libraries for the system.
# Also tries to find the header if it can, but can still be used if it can't find it.
# By default, it will look in the project path and also on the path given by the environment variable PGE_ROOT.
find_package(PGE)

# List of all source files used to create the final executable
set(
    FINDPGE_SOURCE_FILES
    "${PROJECT_SOURCE_DIR}/src/main.cpp"
    "${PROJECT_SOURCE_DIR}/src/olcPixelGameEngine.cpp"
)

# Creating our executable
add_executable(
    ${PROJECT_NAME}
    ${FINDPGE_SOURCE_FILES}
)

# Link to the PGE.
# This will link to the correct libraries needed by each platform and also provide the include paths needed.
target_link_libraries(${PROJECT_NAME} PRIVATE PGE)

# If it becomes necessary to have a target with only the include paths, it is possible to use the variable PGE_INCLUDE_DIRS instead as in
# target_include_directories(${PROJECT_NAME} PRIVATE ${PGE_INCLUDE_DIRS})
