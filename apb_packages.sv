	`include "apb_interface.sv"

package apb_agent_pkg;
    import uvm_pkg::*;
	`include "apb_configuration.sv"
    `include "apb_sequence_item.sv" 
    `include "apb_sequencer.sv"
    `include "apb_sequence.sv"
    `include "apb_driver.sv"
	`include "apb_monitor.sv"
	`include "apb_agent.sv"	
endpackage: apb_agent_pkg