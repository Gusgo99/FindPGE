#[=======================================================================[.rst:
FindPGE
-------

Finds the Pixel Game Engine.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

``PGE``
  The Pixel Game Engine library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``PGE_FOUND``
  True if the PGE was found.
``PGE_VERSION``
  The version of the Pixel Game Engine header which was found.
``PGE_INCLUDE_DIRS``
  Include directories for the libraries the Pixel Game Engine uses. Optionally, if the header was found the path to it.
``PGE_LIBRARIES``
  Libraries needed to use the Pixel Game Engine.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``PGE_CORE_INCLUDE_DIRS``
  The directory containing ``olcPixelGameEngine.h`` if found.

#]=======================================================================]


# Interface library to which the user should link to
add_library(PGE INTERFACE)

# Look for the header in the project directory and in the directory in PGE_ROOT
find_path(PGE_CORE_INCLUDE_DIRS "olcPixelGameEngine.h" ${PROJECT_SOURCE_DIR}/*)

set(PGE_INCLUDE_DIRS "")

if(NOT "${PGE_CORE_INCLUDE_DIRS}" STREQUAL "PGE_CORE_INCLUDE_DIRS-NOTFOUND")
	# Read the file and serch for the version
	file(READ "${PGE_CORE_INCLUDE_DIRS}/olcPixelGameEngine.h" VERSION LIMIT 1000)
	string(REGEX MATCH "[1-9]\\.[0-9]+" VERSION ${VERSION})

	set(PGE_INCLUDE_DIRS ${PGE_CORE_INCLUDE_DIRS})

	target_include_directories(PGE INTERFACE ${PGE_INCLUDE_DIRS})
	
	message(STATUS "Found olcPixelGameEngine version ${VERSION}")

	set(OlcPGE_FOUND True)
endif()

# List of all libraries we'll need to link when compiling for the specified platform.
set(PGE_LIBRARIES "")

find_package(OpenGL)
target_link_libraries(PGE INTERFACE ${OPENGL_LIBRARIES})
set(PGE_LIBRARIES "${PGE_LIBRARIES};${OPENGL_LIBRARIES}")
target_include_directories(PGE INTERFACE ${OPENGL_INCLUDE_DIRS})
set(PGE_INCLUDE_DIRS} "${PGE_INCLUDE_DIRS};${OPENGL_INCLUDE_DIRS}")

if(WIN32)
	target_link_libraries(PGE INTERFACE user32 gdi32 gdiplus Shlwapi dwmapi stdc++fs)
	set(PGE_LIBRARIES "${PGE_LIBRARIES};user32;gdi32;gdiplus;Shlwapi;dwmapi;stdc++fs")

else()
	find_package(PNG)
	target_link_libraries(PGE INTERFACE ${PNG_LIBRARIES})
	set(PGE_LIBRARIES "${PGE_LIBRARIES};${PNG_LIBRARIES}")
	target_include_directories(PGE INTERFACE ${PNG_INCLUDE_DIRS})
	set(PGE_INCLUDE_DIRS} "${PGE_INCLUDE_DIRS};${PNG_INCLUDE_DIRS}")
	
	if(APPLE)
		find_package(GLUT)
	
		target_link_libraries(PGE INTERFACE ${GLUT_LIBRARY})
		set(PGE_LIBRARIES "${PGE_LIBRARIES};${GLUT_LIBRARY}")
		target_include_directories(PGE INTERFACE ${GLUT_INCLUDE_DIRS})
		set(PGE_INCLUDE_DIRS} "${PGE_INCLUDE_DIRS};${GLUT_INCLUDE_DIRS}")

	elseif(UNIX)
		find_package(Threads)
		target_link_libraries(PGE INTERFACE Threads::Threads)
		set(PGE_LIBRARIES "${PGE_LIBRARIES};Threads::Threads")
		
		find_package(X11)
		target_include_directories(PGE INTERFACE ${X11_INCLUDE_DIRS})
		set(PGE_INCLUDE_DIRS} "${PGE_INCLUDE_DIRS};${X11_INCLUDE_DIRS}")
		target_link_libraries(PGE INTERFACE ${X11_LIBRARIES})
		set(PGE_LIBRARIES "${PGE_LIBRARIES};${X11_LIBRARIES}")

	endif()
endif()
