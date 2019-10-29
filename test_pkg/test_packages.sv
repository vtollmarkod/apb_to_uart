package test_pkg;//cookbook 32
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	import apb_agent_pkg::*;
  	import uart_agent_pkg::*; 
  	`include "environment_configuration.sv"
	`include "my_virtual_sequencer.sv"
  	`include "my_virtual_sequence.sv"
	`include "my_environment.sv"
	`include "apb_tests.sv"
endpackage:test_pkg