# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/nuo/hallwayROS/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/nuo/hallwayROS/build

# Include any dependencies generated for this target.
include qpoases/CMakeFiles/example1b.dir/depend.make

# Include the progress variables for this target.
include qpoases/CMakeFiles/example1b.dir/progress.make

# Include the compile flags for this target's objects.
include qpoases/CMakeFiles/example1b.dir/flags.make

qpoases/CMakeFiles/example1b.dir/examples/example1b.cpp.o: qpoases/CMakeFiles/example1b.dir/flags.make
qpoases/CMakeFiles/example1b.dir/examples/example1b.cpp.o: /home/nuo/hallwayROS/src/qpoases/examples/example1b.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/nuo/hallwayROS/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object qpoases/CMakeFiles/example1b.dir/examples/example1b.cpp.o"
	cd /home/nuo/hallwayROS/build/qpoases && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/example1b.dir/examples/example1b.cpp.o -c /home/nuo/hallwayROS/src/qpoases/examples/example1b.cpp

qpoases/CMakeFiles/example1b.dir/examples/example1b.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/example1b.dir/examples/example1b.cpp.i"
	cd /home/nuo/hallwayROS/build/qpoases && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/nuo/hallwayROS/src/qpoases/examples/example1b.cpp > CMakeFiles/example1b.dir/examples/example1b.cpp.i

qpoases/CMakeFiles/example1b.dir/examples/example1b.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/example1b.dir/examples/example1b.cpp.s"
	cd /home/nuo/hallwayROS/build/qpoases && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/nuo/hallwayROS/src/qpoases/examples/example1b.cpp -o CMakeFiles/example1b.dir/examples/example1b.cpp.s

qpoases/CMakeFiles/example1b.dir/examples/example1b.cpp.o.requires:

.PHONY : qpoases/CMakeFiles/example1b.dir/examples/example1b.cpp.o.requires

qpoases/CMakeFiles/example1b.dir/examples/example1b.cpp.o.provides: qpoases/CMakeFiles/example1b.dir/examples/example1b.cpp.o.requires
	$(MAKE) -f qpoases/CMakeFiles/example1b.dir/build.make qpoases/CMakeFiles/example1b.dir/examples/example1b.cpp.o.provides.build
.PHONY : qpoases/CMakeFiles/example1b.dir/examples/example1b.cpp.o.provides

qpoases/CMakeFiles/example1b.dir/examples/example1b.cpp.o.provides.build: qpoases/CMakeFiles/example1b.dir/examples/example1b.cpp.o


# Object files for target example1b
example1b_OBJECTS = \
"CMakeFiles/example1b.dir/examples/example1b.cpp.o"

# External object files for target example1b
example1b_EXTERNAL_OBJECTS =

/home/nuo/hallwayROS/devel/lib/qpoases/example1b: qpoases/CMakeFiles/example1b.dir/examples/example1b.cpp.o
/home/nuo/hallwayROS/devel/lib/qpoases/example1b: qpoases/CMakeFiles/example1b.dir/build.make
/home/nuo/hallwayROS/devel/lib/qpoases/example1b: /home/nuo/hallwayROS/devel/lib/libqpoases.so
/home/nuo/hallwayROS/devel/lib/qpoases/example1b: qpoases/CMakeFiles/example1b.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/nuo/hallwayROS/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable /home/nuo/hallwayROS/devel/lib/qpoases/example1b"
	cd /home/nuo/hallwayROS/build/qpoases && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/example1b.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
qpoases/CMakeFiles/example1b.dir/build: /home/nuo/hallwayROS/devel/lib/qpoases/example1b

.PHONY : qpoases/CMakeFiles/example1b.dir/build

qpoases/CMakeFiles/example1b.dir/requires: qpoases/CMakeFiles/example1b.dir/examples/example1b.cpp.o.requires

.PHONY : qpoases/CMakeFiles/example1b.dir/requires

qpoases/CMakeFiles/example1b.dir/clean:
	cd /home/nuo/hallwayROS/build/qpoases && $(CMAKE_COMMAND) -P CMakeFiles/example1b.dir/cmake_clean.cmake
.PHONY : qpoases/CMakeFiles/example1b.dir/clean

qpoases/CMakeFiles/example1b.dir/depend:
	cd /home/nuo/hallwayROS/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/nuo/hallwayROS/src /home/nuo/hallwayROS/src/qpoases /home/nuo/hallwayROS/build /home/nuo/hallwayROS/build/qpoases /home/nuo/hallwayROS/build/qpoases/CMakeFiles/example1b.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : qpoases/CMakeFiles/example1b.dir/depend
