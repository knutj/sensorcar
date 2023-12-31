## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]



##LEDs -- Represents the digital output signal for the motors
##IN1 Left Side Motors
set_property PACKAGE_PIN U16 [get_ports {led[0]}]          
	set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
##IN2 Left Side Motors
set_property PACKAGE_PIN E19 [get_ports {led[1]}]          		
	set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
##IN3 Left Side Motors
set_property PACKAGE_PIN U19 [get_ports {led[2]}]          
	set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
##IN4 Left Side Motors
set_property PACKAGE_PIN V19 [get_ports {led[3]}]          	
	set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
##IN1 Right Side Motors
set_property PACKAGE_PIN W18 [get_ports {led[4]}]          
	set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
##IN2 Right Side Motors
set_property PACKAGE_PIN U15 [get_ports {led[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]  
##IN3 Right Side Motors
set_property PACKAGE_PIN U14 [get_ports {led[6]}]		   	
	set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
##IN4 Right Side Motors
set_property PACKAGE_PIN V14 [get_ports {led[7]}]		   
	set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
##ENA/ENB Both Motors		
set_property PACKAGE_PIN V13 [get_ports {led[8]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]



##7 segment display
set_property PACKAGE_PIN W7 [get_ports {seg[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]
set_property PACKAGE_PIN W6 [get_ports {seg[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
set_property PACKAGE_PIN U8 [get_ports {seg[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
set_property PACKAGE_PIN V8 [get_ports {seg[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
set_property PACKAGE_PIN U5 [get_ports {seg[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
set_property PACKAGE_PIN V5 [get_ports {seg[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
set_property PACKAGE_PIN U7 [get_ports {seg[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]

set_property PACKAGE_PIN V7 [get_ports {seg[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {seg[7]}]

set_property PACKAGE_PIN U2 [get_ports {an[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]



##Buttons
set_property PACKAGE_PIN U18 [get_ports rst]
    set_property IOSTANDARD LVCMOS33 [get_ports rst]



##Pmod Header JA    -- Right Side Motors
##Sch name = JA1    -- I01 on level shifter     -- IN1 on motor board
set_property PACKAGE_PIN J1 [get_ports {dig_out[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_out[4]}]
##Sch name = JA2    -- I02 on level shifter     -- IN2 on motor board
set_property PACKAGE_PIN L2 [get_ports {dig_out[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_out[5]}]
##Sch name = JA3    -- I03 on level shifter     -- IN3 on motor board
set_property PACKAGE_PIN J2 [get_ports {dig_out[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_out[6]}]
##Sch name = JA4    -- I04 on level shifter     -- IN4 on motor board
set_property PACKAGE_PIN G2 [get_ports {dig_out[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_out[7]}]
##Sch name = JA7    -- I05 on level shifter     -- ENA on motor board
set_property PACKAGE_PIN H1 [get_ports {dig_out[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_out[8]}]
##Sch name = JA8    -- I06 on level shifter     -- ENB on motor board
set_property PACKAGE_PIN K2 [get_ports {dig_out[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_out[8]}]



##Pmod Header JXADC     -- Left Side Motors + Ultrasonic Sensor
##Sch name = XA1_P      -- I01 on level shifter     -- IN1 on motor board
set_property PACKAGE_PIN J3 [get_ports {dig_out[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_out[0]}]
##Sch name = XA2_P      -- I02 on level shifter     -- IN2 on motor board
set_property PACKAGE_PIN L3 [get_ports {dig_out[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_out[1]}]
##Sch name = XA3_P      -- I03 on level shifter     -- IN3 on motor board
set_property PACKAGE_PIN M2 [get_ports {dig_out[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_out[2]}]
##Sch name = XA4_P      -- I04 on level shifter     -- IN4 on motor board
set_property PACKAGE_PIN N2 [get_ports {dig_out[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_out[3]}]
##Sch name = XA1_N      -- I05 on level shifter     -- ENA on motor board
set_property PACKAGE_PIN K3 [get_ports {dig_out[8]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_out[8]}]
##Sch name = XA2_N      -- I06 on level shifter     -- ENB on motor board
set_property PACKAGE_PIN M3 [get_ports {dig_out[8]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_out[8]}]
##Sch name = XA3_N      -- I07 on level shifter     -- TRIG IN on sensor board
set_property PACKAGE_PIN M1 [get_ports trig]				
	set_property IOSTANDARD LVCMOS33 [get_ports trig]
##Sch name = XA4_N      -- I08 on level shifter     -- ECHO OUT on sensor board
set_property PACKAGE_PIN N1 [get_ports echo]				
	set_property IOSTANDARD LVCMOS33 [get_ports echo]



##Pmod Header JB    -- Placeholder for dig_in
##Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports {dig_in[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_in[0]}]
##Sch name = JB2
set_property PACKAGE_PIN A16 [get_ports {dig_in[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_in[1]}]
##Sch name = JB3
set_property PACKAGE_PIN B15 [get_ports {dig_in[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_in[2]}]
##Sch name = JB4
set_property PACKAGE_PIN B16 [get_ports {dig_in[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_in[3]}]
##Sch name = JB7
set_property PACKAGE_PIN A15 [get_ports {dig_in[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_in[4]}]
##Sch name = JB8
set_property PACKAGE_PIN A17 [get_ports {dig_in[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_in[5]}]
##Sch name = JB9
set_property PACKAGE_PIN C15 [get_ports {dig_in[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_in[6]}]
##Sch name = JB10 
set_property PACKAGE_PIN C16 [get_ports {dig_in[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dig_in[7]}]