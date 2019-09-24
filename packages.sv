`include "my_interface.sv"
package my_pkg;
    import uvm_pkg::*;

    `include "apb_sequence_item.sv" 
    `include "apb_sequencer.sv"
    `include "apb_sequence.sv"
    `include "apb_driver.sv"
	`include "apb_monitor.sv"
	`include "apb_agent.sv"	
    `include "my_enviroment.sv"
    `include "my_tests.sv"


endpackage: my_pkg