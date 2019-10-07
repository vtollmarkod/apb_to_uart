`include "uart_interface.sv"

package uart_agent_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	`include "uart_sequence_item.sv"
	`include "uart_monitor.sv"
	`include "uart_agent.sv"
	`include "uart_configuration.sv"
endpackage:uart_agent_pkg