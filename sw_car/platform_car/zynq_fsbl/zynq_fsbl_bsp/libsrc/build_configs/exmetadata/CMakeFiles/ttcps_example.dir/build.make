# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.24

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Produce verbose output by default.
VERBOSE = 1

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/knutjb/Xilinx/Vitis/2023.2/tps/lnx64/cmake-3.24.2/bin/cmake

# The command to remove a file.
RM = /home/knutjb/Xilinx/Vitis/2023.2/tps/lnx64/cmake-3.24.2/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/knutjb/Vivado/sw_car/platform_car/zynq_fsbl/zynq_fsbl_bsp/libsrc/build_configs/exmetadata

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/knutjb/Vivado/sw_car/platform_car/zynq_fsbl/zynq_fsbl_bsp/libsrc/build_configs/exmetadata

# Utility rule file for ttcps_example.

# Include any custom commands dependencies for this target.
include CMakeFiles/ttcps_example.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/ttcps_example.dir/progress.make

CMakeFiles/ttcps_example:
	lopper -f -O /home/knutjb/Vivado/sw_car/platform_car/zynq_fsbl/zynq_fsbl_bsp/libsrc/ttcps /home/knutjb/Vivado/sw_car/platform_car/zynq_fsbl/zynq_fsbl_bsp/hw_artifacts/ps7_cortexa9_0_baremetal.dts -- bmcmake_metadata_xlnx ps7_cortexa9_0 /home/knutjb/Xilinx/Vitis/2023.2/data/embeddedsw/XilinxProcessorIPLib/drivers/ttcps_v3_18/examples drvcmake_metadata

ttcps_example: CMakeFiles/ttcps_example
ttcps_example: CMakeFiles/ttcps_example.dir/build.make
.PHONY : ttcps_example

# Rule to build all files generated by this target.
CMakeFiles/ttcps_example.dir/build: ttcps_example
.PHONY : CMakeFiles/ttcps_example.dir/build

CMakeFiles/ttcps_example.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/ttcps_example.dir/cmake_clean.cmake
.PHONY : CMakeFiles/ttcps_example.dir/clean

CMakeFiles/ttcps_example.dir/depend:
	cd /home/knutjb/Vivado/sw_car/platform_car/zynq_fsbl/zynq_fsbl_bsp/libsrc/build_configs/exmetadata && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/knutjb/Vivado/sw_car/platform_car/zynq_fsbl/zynq_fsbl_bsp/libsrc/build_configs/exmetadata /home/knutjb/Vivado/sw_car/platform_car/zynq_fsbl/zynq_fsbl_bsp/libsrc/build_configs/exmetadata /home/knutjb/Vivado/sw_car/platform_car/zynq_fsbl/zynq_fsbl_bsp/libsrc/build_configs/exmetadata /home/knutjb/Vivado/sw_car/platform_car/zynq_fsbl/zynq_fsbl_bsp/libsrc/build_configs/exmetadata /home/knutjb/Vivado/sw_car/platform_car/zynq_fsbl/zynq_fsbl_bsp/libsrc/build_configs/exmetadata/CMakeFiles/ttcps_example.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/ttcps_example.dir/depend

