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
CMAKE_SOURCE_DIR = /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp

# Utility rule file for combined.

# Include any custom commands dependencies for this target.
include libsrc/CMakeFiles/combined.dir/compiler_depend.make

# Include the progress variables for this target.
include libsrc/CMakeFiles/combined.dir/progress.make

libsrc/CMakeFiles/combined: libsrc/coresightps_dcc/src/libcoresightps_dcc.a
libsrc/CMakeFiles/combined: libsrc/devcfg/src/libdevcfg.a
libsrc/CMakeFiles/combined: libsrc/dmaps/src/libdmaps.a
libsrc/CMakeFiles/combined: libsrc/emacps/src/libemacps.a
libsrc/CMakeFiles/combined: libsrc/gpiops/src/libgpiops.a
libsrc/CMakeFiles/combined: libsrc/qspips/src/libqspips.a
libsrc/CMakeFiles/combined: libsrc/scugic/src/libscugic.a
libsrc/CMakeFiles/combined: libsrc/scutimer/src/libscutimer.a
libsrc/CMakeFiles/combined: libsrc/scuwdt/src/libscuwdt.a
libsrc/CMakeFiles/combined: libsrc/sdps/src/libsdps.a
libsrc/CMakeFiles/combined: libsrc/ttcps/src/libttcps.a
libsrc/CMakeFiles/combined: libsrc/uartps/src/libuartps.a
libsrc/CMakeFiles/combined: libsrc/usbps/src/libusbps.a
libsrc/CMakeFiles/combined: libsrc/xadcps/src/libxadcps.a
	arm-none-eabi-ar -qcs /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libxil.a /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/coresightps_dcc/src/CMakeFiles/coresightps_dcc.dir/xcoresightpsdcc.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/devcfg/src/CMakeFiles/devcfg.dir/xdevcfg.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/devcfg/src/CMakeFiles/devcfg.dir/xdevcfg_g.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/devcfg/src/CMakeFiles/devcfg.dir/xdevcfg_hw.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/devcfg/src/CMakeFiles/devcfg.dir/xdevcfg_intr.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/devcfg/src/CMakeFiles/devcfg.dir/xdevcfg_selftest.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/devcfg/src/CMakeFiles/devcfg.dir/xdevcfg_sinit.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/dmaps/src/CMakeFiles/dmaps.dir/xdmaps.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/dmaps/src/CMakeFiles/dmaps.dir/xdmaps_g.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/dmaps/src/CMakeFiles/dmaps.dir/xdmaps_hw.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/dmaps/src/CMakeFiles/dmaps.dir/xdmaps_selftest.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/dmaps/src/CMakeFiles/dmaps.dir/xdmaps_sinit.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/emacps/src/CMakeFiles/emacps.dir/xemacps_g.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/emacps/src/CMakeFiles/emacps.dir/xemacps_hw.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/emacps/src/CMakeFiles/emacps.dir/xemacps_control.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/emacps/src/CMakeFiles/emacps.dir/xemacps.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/emacps/src/CMakeFiles/emacps.dir/xemacps_bdring.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/emacps/src/CMakeFiles/emacps.dir/xemacps_sinit.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/emacps/src/CMakeFiles/emacps.dir/xemacps_intr.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/gpiops/src/CMakeFiles/gpiops.dir/xgpiops_g.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/gpiops/src/CMakeFiles/gpiops.dir/xgpiops_selftest.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/gpiops/src/CMakeFiles/gpiops.dir/xgpiops.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/gpiops/src/CMakeFiles/gpiops.dir/xgpiops_hw.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/gpiops/src/CMakeFiles/gpiops.dir/xgpiops_sinit.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/gpiops/src/CMakeFiles/gpiops.dir/xgpiops_intr.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_g.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_hw.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_options.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_selftest.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_sinit.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/scugic/src/CMakeFiles/scugic.dir/xscugic_hw.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/scugic/src/CMakeFiles/scugic.dir/xscugic_g.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/scugic/src/CMakeFiles/scugic.dir/xscugic_sinit.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/scugic/src/CMakeFiles/scugic.dir/xscugic_intr.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/scugic/src/CMakeFiles/scugic.dir/xscugic_selftest.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/scugic/src/CMakeFiles/scugic.dir/xscugic.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/scutimer/src/CMakeFiles/scutimer.dir/xscutimer.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/scutimer/src/CMakeFiles/scutimer.dir/xscutimer_g.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/scutimer/src/CMakeFiles/scutimer.dir/xscutimer_selftest.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/scutimer/src/CMakeFiles/scutimer.dir/xscutimer_sinit.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/scuwdt/src/CMakeFiles/scuwdt.dir/xscuwdt.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/scuwdt/src/CMakeFiles/scuwdt.dir/xscuwdt_g.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/scuwdt/src/CMakeFiles/scuwdt.dir/xscuwdt_selftest.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/scuwdt/src/CMakeFiles/scuwdt.dir/xscuwdt_sinit.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_host.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_options.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_card.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_sinit.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/sdps/src/CMakeFiles/sdps.dir/xsdps_g.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/ttcps/src/CMakeFiles/ttcps.dir/xttcps_options.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/ttcps/src/CMakeFiles/ttcps.dir/xttcps_selftest.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/ttcps/src/CMakeFiles/ttcps.dir/xttcps.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/ttcps/src/CMakeFiles/ttcps.dir/xttcps_g.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/ttcps/src/CMakeFiles/ttcps.dir/xttcps_sinit.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/uartps/src/CMakeFiles/uartps.dir/xuartps_hw.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/uartps/src/CMakeFiles/uartps.dir/xuartps_selftest.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/uartps/src/CMakeFiles/uartps.dir/xuartps_intr.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/uartps/src/CMakeFiles/uartps.dir/xuartps_g.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/uartps/src/CMakeFiles/uartps.dir/xuartps.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/uartps/src/CMakeFiles/uartps.dir/xuartps_sinit.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/uartps/src/CMakeFiles/uartps.dir/xuartps_options.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/usbps/src/CMakeFiles/usbps.dir/xusbps.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/usbps/src/CMakeFiles/usbps.dir/xusbps_endpoint.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/usbps/src/CMakeFiles/usbps.dir/xusbps_g.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/usbps/src/CMakeFiles/usbps.dir/xusbps_hw.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/usbps/src/CMakeFiles/usbps.dir/xusbps_intr.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/usbps/src/CMakeFiles/usbps.dir/xusbps_sinit.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/xadcps/src/CMakeFiles/xadcps.dir/xadcps.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/xadcps/src/CMakeFiles/xadcps.dir/xadcps_g.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/xadcps/src/CMakeFiles/xadcps.dir/xadcps_intr.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/xadcps/src/CMakeFiles/xadcps.dir/xadcps_selftest.c.obj /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/xadcps/src/CMakeFiles/xadcps.dir/xadcps_sinit.c.obj
	/home/knutjb/Xilinx/Vitis/2023.2/tps/lnx64/cmake-3.24.2/bin/cmake -E copy /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libxil.a /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/lib

combined: libsrc/CMakeFiles/combined
combined: libsrc/CMakeFiles/combined.dir/build.make
.PHONY : combined

# Rule to build all files generated by this target.
libsrc/CMakeFiles/combined.dir/build: combined
.PHONY : libsrc/CMakeFiles/combined.dir/build

libsrc/CMakeFiles/combined.dir/clean:
	cd /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc && $(CMAKE_COMMAND) -P CMakeFiles/combined.dir/cmake_clean.cmake
.PHONY : libsrc/CMakeFiles/combined.dir/clean

libsrc/CMakeFiles/combined.dir/depend:
	cd /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc /home/knutjb/Vivado/sw_car/new_car/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/CMakeFiles/combined.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : libsrc/CMakeFiles/combined.dir/depend

