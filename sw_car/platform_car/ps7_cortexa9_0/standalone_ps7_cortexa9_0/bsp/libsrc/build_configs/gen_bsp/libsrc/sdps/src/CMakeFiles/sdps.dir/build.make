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
CMAKE_SOURCE_DIR = /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp

# Include any dependencies generated for this target.
include libsrc/sdps/src/CMakeFiles/sdps.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include libsrc/sdps/src/CMakeFiles/sdps.dir/compiler_depend.make

# Include the progress variables for this target.
include libsrc/sdps/src/CMakeFiles/sdps.dir/progress.make

# Include the compile flags for this target's objects.
include libsrc/sdps/src/CMakeFiles/sdps.dir/flags.make

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_host.c.obj: libsrc/sdps/src/CMakeFiles/sdps.dir/flags.make
libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_host.c.obj: /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_host.c
libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_host.c.obj: libsrc/sdps/src/CMakeFiles/sdps.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_host.c.obj"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_host.c.obj -MF CMakeFiles/sdps.dir/xsdps_host.c.obj.d -o CMakeFiles/sdps.dir/xsdps_host.c.obj -c /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_host.c

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_host.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sdps.dir/xsdps_host.c.i"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_host.c > CMakeFiles/sdps.dir/xsdps_host.c.i

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_host.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sdps.dir/xsdps_host.c.s"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_host.c -o CMakeFiles/sdps.dir/xsdps_host.c.s

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_options.c.obj: libsrc/sdps/src/CMakeFiles/sdps.dir/flags.make
libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_options.c.obj: /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_options.c
libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_options.c.obj: libsrc/sdps/src/CMakeFiles/sdps.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_options.c.obj"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_options.c.obj -MF CMakeFiles/sdps.dir/xsdps_options.c.obj.d -o CMakeFiles/sdps.dir/xsdps_options.c.obj -c /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_options.c

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_options.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sdps.dir/xsdps_options.c.i"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_options.c > CMakeFiles/sdps.dir/xsdps_options.c.i

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_options.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sdps.dir/xsdps_options.c.s"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_options.c -o CMakeFiles/sdps.dir/xsdps_options.c.s

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_card.c.obj: libsrc/sdps/src/CMakeFiles/sdps.dir/flags.make
libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_card.c.obj: /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_card.c
libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_card.c.obj: libsrc/sdps/src/CMakeFiles/sdps.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_card.c.obj"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_card.c.obj -MF CMakeFiles/sdps.dir/xsdps_card.c.obj.d -o CMakeFiles/sdps.dir/xsdps_card.c.obj -c /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_card.c

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_card.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sdps.dir/xsdps_card.c.i"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_card.c > CMakeFiles/sdps.dir/xsdps_card.c.i

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_card.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sdps.dir/xsdps_card.c.s"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_card.c -o CMakeFiles/sdps.dir/xsdps_card.c.s

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_sinit.c.obj: libsrc/sdps/src/CMakeFiles/sdps.dir/flags.make
libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_sinit.c.obj: /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_sinit.c
libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_sinit.c.obj: libsrc/sdps/src/CMakeFiles/sdps.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_sinit.c.obj"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_sinit.c.obj -MF CMakeFiles/sdps.dir/xsdps_sinit.c.obj.d -o CMakeFiles/sdps.dir/xsdps_sinit.c.obj -c /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_sinit.c

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_sinit.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sdps.dir/xsdps_sinit.c.i"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_sinit.c > CMakeFiles/sdps.dir/xsdps_sinit.c.i

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_sinit.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sdps.dir/xsdps_sinit.c.s"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_sinit.c -o CMakeFiles/sdps.dir/xsdps_sinit.c.s

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps.c.obj: libsrc/sdps/src/CMakeFiles/sdps.dir/flags.make
libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps.c.obj: /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps.c
libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps.c.obj: libsrc/sdps/src/CMakeFiles/sdps.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building C object libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps.c.obj"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps.c.obj -MF CMakeFiles/sdps.dir/xsdps.c.obj.d -o CMakeFiles/sdps.dir/xsdps.c.obj -c /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps.c

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sdps.dir/xsdps.c.i"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps.c > CMakeFiles/sdps.dir/xsdps.c.i

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sdps.dir/xsdps.c.s"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps.c -o CMakeFiles/sdps.dir/xsdps.c.s

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_g.c.obj: libsrc/sdps/src/CMakeFiles/sdps.dir/flags.make
libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_g.c.obj: /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_g.c
libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_g.c.obj: libsrc/sdps/src/CMakeFiles/sdps.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_g.c.obj"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_g.c.obj -MF CMakeFiles/sdps.dir/xsdps_g.c.obj.d -o CMakeFiles/sdps.dir/xsdps_g.c.obj -c /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_g.c

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_g.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sdps.dir/xsdps_g.c.i"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_g.c > CMakeFiles/sdps.dir/xsdps_g.c.i

libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_g.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sdps.dir/xsdps_g.c.s"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && /home/knutjb/Xilinx/Vitis/2023.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src/xsdps_g.c -o CMakeFiles/sdps.dir/xsdps_g.c.s

# Object files for target sdps
sdps_OBJECTS = \
"CMakeFiles/sdps.dir/xsdps_host.c.obj" \
"CMakeFiles/sdps.dir/xsdps_options.c.obj" \
"CMakeFiles/sdps.dir/xsdps_card.c.obj" \
"CMakeFiles/sdps.dir/xsdps_sinit.c.obj" \
"CMakeFiles/sdps.dir/xsdps.c.obj" \
"CMakeFiles/sdps.dir/xsdps_g.c.obj"

# External object files for target sdps
sdps_EXTERNAL_OBJECTS =

libsrc/sdps/src/libsdps.a: libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_host.c.obj
libsrc/sdps/src/libsdps.a: libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_options.c.obj
libsrc/sdps/src/libsdps.a: libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_card.c.obj
libsrc/sdps/src/libsdps.a: libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_sinit.c.obj
libsrc/sdps/src/libsdps.a: libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps.c.obj
libsrc/sdps/src/libsdps.a: libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_g.c.obj
libsrc/sdps/src/libsdps.a: libsrc/sdps/src/CMakeFiles/sdps.dir/build.make
libsrc/sdps/src/libsdps.a: libsrc/sdps/src/CMakeFiles/sdps.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Linking C static library libsdps.a"
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && $(CMAKE_COMMAND) -P CMakeFiles/sdps.dir/cmake_clean_target.cmake
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/sdps.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
libsrc/sdps/src/CMakeFiles/sdps.dir/build: libsrc/sdps/src/libsdps.a
.PHONY : libsrc/sdps/src/CMakeFiles/sdps.dir/build

libsrc/sdps/src/CMakeFiles/sdps.dir/clean:
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src && $(CMAKE_COMMAND) -P CMakeFiles/sdps.dir/cmake_clean.cmake
.PHONY : libsrc/sdps/src/CMakeFiles/sdps.dir/clean

libsrc/sdps/src/CMakeFiles/sdps.dir/depend:
	cd /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/sdps/src /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src /home/knutjb/Vivado/sw_car/platform_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src/CMakeFiles/sdps.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : libsrc/sdps/src/CMakeFiles/sdps.dir/depend
