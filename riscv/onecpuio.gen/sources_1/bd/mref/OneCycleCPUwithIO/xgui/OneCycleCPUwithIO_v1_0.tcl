# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "DMADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DMDATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DRADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DRDATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "IMADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "IMDATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "OPCODE_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PCDATA_WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.DMADDR_WIDTH { PARAM_VALUE.DMADDR_WIDTH } {
	# Procedure called to update DMADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DMADDR_WIDTH { PARAM_VALUE.DMADDR_WIDTH } {
	# Procedure called to validate DMADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.DMDATA_WIDTH { PARAM_VALUE.DMDATA_WIDTH } {
	# Procedure called to update DMDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DMDATA_WIDTH { PARAM_VALUE.DMDATA_WIDTH } {
	# Procedure called to validate DMDATA_WIDTH
	return true
}

proc update_PARAM_VALUE.DRADDR_WIDTH { PARAM_VALUE.DRADDR_WIDTH } {
	# Procedure called to update DRADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DRADDR_WIDTH { PARAM_VALUE.DRADDR_WIDTH } {
	# Procedure called to validate DRADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.DRDATA_WIDTH { PARAM_VALUE.DRDATA_WIDTH } {
	# Procedure called to update DRDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DRDATA_WIDTH { PARAM_VALUE.DRDATA_WIDTH } {
	# Procedure called to validate DRDATA_WIDTH
	return true
}

proc update_PARAM_VALUE.IMADDR_WIDTH { PARAM_VALUE.IMADDR_WIDTH } {
	# Procedure called to update IMADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IMADDR_WIDTH { PARAM_VALUE.IMADDR_WIDTH } {
	# Procedure called to validate IMADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.IMDATA_WIDTH { PARAM_VALUE.IMDATA_WIDTH } {
	# Procedure called to update IMDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IMDATA_WIDTH { PARAM_VALUE.IMDATA_WIDTH } {
	# Procedure called to validate IMDATA_WIDTH
	return true
}

proc update_PARAM_VALUE.OPCODE_WIDTH { PARAM_VALUE.OPCODE_WIDTH } {
	# Procedure called to update OPCODE_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OPCODE_WIDTH { PARAM_VALUE.OPCODE_WIDTH } {
	# Procedure called to validate OPCODE_WIDTH
	return true
}

proc update_PARAM_VALUE.PCDATA_WIDTH { PARAM_VALUE.PCDATA_WIDTH } {
	# Procedure called to update PCDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PCDATA_WIDTH { PARAM_VALUE.PCDATA_WIDTH } {
	# Procedure called to validate PCDATA_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.PCDATA_WIDTH { MODELPARAM_VALUE.PCDATA_WIDTH PARAM_VALUE.PCDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PCDATA_WIDTH}] ${MODELPARAM_VALUE.PCDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.IMADDR_WIDTH { MODELPARAM_VALUE.IMADDR_WIDTH PARAM_VALUE.IMADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IMADDR_WIDTH}] ${MODELPARAM_VALUE.IMADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.IMDATA_WIDTH { MODELPARAM_VALUE.IMDATA_WIDTH PARAM_VALUE.IMDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IMDATA_WIDTH}] ${MODELPARAM_VALUE.IMDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.DRADDR_WIDTH { MODELPARAM_VALUE.DRADDR_WIDTH PARAM_VALUE.DRADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DRADDR_WIDTH}] ${MODELPARAM_VALUE.DRADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.DRDATA_WIDTH { MODELPARAM_VALUE.DRDATA_WIDTH PARAM_VALUE.DRDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DRDATA_WIDTH}] ${MODELPARAM_VALUE.DRDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.DMADDR_WIDTH { MODELPARAM_VALUE.DMADDR_WIDTH PARAM_VALUE.DMADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DMADDR_WIDTH}] ${MODELPARAM_VALUE.DMADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.DMDATA_WIDTH { MODELPARAM_VALUE.DMDATA_WIDTH PARAM_VALUE.DMDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DMDATA_WIDTH}] ${MODELPARAM_VALUE.DMDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.OPCODE_WIDTH { MODELPARAM_VALUE.OPCODE_WIDTH PARAM_VALUE.OPCODE_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OPCODE_WIDTH}] ${MODELPARAM_VALUE.OPCODE_WIDTH}
}

