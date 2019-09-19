class my_enviroment extends uvm_env;
	`uvm_component_utils (my_env)

	apb_agent apb_agent_h;

	function new(string name , uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		apb_agent_h = apb_agent::type_id::create("apb_agent_h");
	endfunction

endclass:my_enviroment
