#########################################################################################
# CLOCK:
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {clk_i} ];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk_i}];
#########################################################################################
# RESET in real lab:
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports {rst_i} ]; # BTNC 
#########################################################################################
# BUTTONS in real lab: 
set_property -dict { PACKAGE_PIN P18 IOSTANDARD LVCMOS33 } [get_ports { button_i[0] }]; # BTND
set_property -dict { PACKAGE_PIN P17 IOSTANDARD LVCMOS33 } [get_ports { button_i[1] }]; # BTNL
set_property -dict { PACKAGE_PIN M17 IOSTANDARD LVCMOS33 } [get_ports { button_i[2] }]; # BTNR
#########################################################################################
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports { led_o[0] }]; # LED0
set_property -dict { PACKAGE_PIN K15 IOSTANDARD LVCMOS33 } [get_ports { led_o[1] }]; # LED1
set_property -dict { PACKAGE_PIN J13 IOSTANDARD LVCMOS33 } [get_ports { led_o[2] }]; # LED2
set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports { led_o[3] }]; # LED3
set_property -dict { PACKAGE_PIN R18 IOSTANDARD LVCMOS33 } [get_ports { led_o[4] }]; # LED4
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports { led_o[5] }]; # LED5
set_property -dict { PACKAGE_PIN U17 IOSTANDARD LVCMOS33 } [get_ports { led_o[6] }]; # LED6
set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports { led_o[7] }]; # LED7
######################################################################################### 
set_property -dict { PACKAGE_PIN R12 IOSTANDARD LVCMOS33 } [get_ports { led_clk_o }]; # LED_RGB
# Voltage supply for the configuration interfaces on board:
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
#########################################################################################