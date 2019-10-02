class my_enviroment extends uvm_env;
	`uvm_component_utils (my_enviroment)


	//my_virtual_sequencer my_virtual_sequencer_h;
  
	apb_agent apb_agent_h;
  	uart_agent uart_agent_h;

	function new(string name , uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
      	apb_agent_h = apb_agent::type_id::create("apb_agent_h",this);
      	uart_agent_h = uart_agent::type_id::create("uart_agent_h",this);
      	//my_virtual_sequencer_h = my_virtual_sequencer ::type_id::create("my_virtual_sequencer_h",this);
	endfunction

  
  	virtual function void connect_phase (uvm_phase phase);
  		//my_virtual_sequencer_h.apb_sequencer_h = apb_agent.apb_sequencer_h;
  	endfunction
  	
endclass:my_enviroment

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



