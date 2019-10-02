`include "uart_interface.sv"

package uart_agent_pkg;
	import uvm_pkg::*;
	`include "uart_sequence_item.sv"
	`include "uart_monitor.sv"
	`include "uart_agent.sv"
endpackage:uart_agent_pkg