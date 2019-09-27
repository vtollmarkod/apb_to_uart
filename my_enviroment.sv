class my_enviroment extends uvm_env;
	`uvm_component_utils (my_enviroment)

  import apb_agent_pkg::*;
  import uart_agent_pkg::*;

	apb_agent apb_agent_h;
  uart_agent uart_agent_h;

	function new(string name , uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
      apb_agent_h = apb_agent::type_id::create("apb_agent_h",this);
      uart_agent_h = uart_agent::type_id::create("uart_agent_h",this);
	endfunction



/*
    /// Reset Phase Task, reset is Active LOW
    task reset_phase(uvm_phase phase);
      phase.raise_objection(this);
      dut_vi.reset = 0;
      #100;
      dut_vi.reset = 1;
      phase.drop_objection(this);
    endtask: reset_phase 
*/


endclass:my_enviroment
