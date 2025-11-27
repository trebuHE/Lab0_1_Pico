#########################################################################################
# CLOCK:
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {clk_i} ];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk_i}];
#########################################################################################
# RESET in real lab:
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports {rst_i} ]; # BTNC
########################################################################################
# BUTTONS in real lab:
set_property -dict { PACKAGE_PIN M18 IOSTANDARD LVCMOS33 } [get_ports { button_i[0] }]; # BTNU
set_property -dict { PACKAGE_PIN P18 IOSTANDARD LVCMOS33 } [get_ports { button_i[1] }]; # BTND
set_property -dict { PACKAGE_PIN P17 IOSTANDARD LVCMOS33 } [get_ports { button_i[2] }]; # BTNL
set_property -dict { PACKAGE_PIN M17 IOSTANDARD LVCMOS33 } [get_ports { button_i[3] }]; # BTNR
#########################################################################################
# LED 7-SEGMENT DISPLAY:
set_property -dict { PACKAGE_PIN T10 IOSTANDARD LVCMOS33 } [get_ports { led7_seg_o[7] }];
set_property -dict { PACKAGE_PIN R10 IOSTANDARD LVCMOS33 } [get_ports { led7_seg_o[6] }];
set_property -dict { PACKAGE_PIN K16 IOSTANDARD LVCMOS33 } [get_ports { led7_seg_o[5] }];
set_property -dict { PACKAGE_PIN K13 IOSTANDARD LVCMOS33 } [get_ports { led7_seg_o[4] }];
set_property -dict { PACKAGE_PIN P15 IOSTANDARD LVCMOS33 } [get_ports { led7_seg_o[3] }];
set_property -dict { PACKAGE_PIN T11 IOSTANDARD LVCMOS33 } [get_ports { led7_seg_o[2] }];
set_property -dict { PACKAGE_PIN L18 IOSTANDARD LVCMOS33 } [get_ports { led7_seg_o[1] }];
set_property -dict { PACKAGE_PIN H15 IOSTANDARD LVCMOS33 } [get_ports { led7_seg_o[0] }];
set_property -dict { PACKAGE_PIN J17 IOSTANDARD LVCMOS33 } [get_ports { led7_an_o[0] }];
set_property -dict { PACKAGE_PIN J18 IOSTANDARD LVCMOS33 } [get_ports { led7_an_o[1] }];
set_property -dict { PACKAGE_PIN T9 IOSTANDARD LVCMOS33 }  [get_ports { led7_an_o[2] }];
set_property -dict { PACKAGE_PIN J14 IOSTANDARD LVCMOS33 } [get_ports { led7_an_o[3] }];
set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports { led7_an_o[4] }];
set_property -dict { PACKAGE_PIN T14 IOSTANDARD LVCMOS33 } [get_ports { led7_an_o[5] }];
set_property -dict { PACKAGE_PIN K2 IOSTANDARD LVCMOS33 } [get_ports { led7_an_o[6] }];
set_property -dict { PACKAGE_PIN U13 IOSTANDARD LVCMOS33 } [get_ports { led7_an_o[7] }];
#########################################################################################
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports { leds_o[0] }];
set_property -dict { PACKAGE_PIN K15 IOSTANDARD LVCMOS33 } [get_ports { leds_o[1] }];
set_property -dict { PACKAGE_PIN J13 IOSTANDARD LVCMOS33 } [get_ports { leds_o[2] }];
set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports { leds_o[3] }];
set_property -dict { PACKAGE_PIN R18 IOSTANDARD LVCMOS33 } [get_ports { leds_o[4] }];
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports { leds_o[5] }];
set_property -dict { PACKAGE_PIN U17 IOSTANDARD LVCMOS33 } [get_ports { leds_o[6] }];
set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports { leds_o[7] }];
#########################################################################################