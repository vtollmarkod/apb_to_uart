class env_cfg extends uvm_object;
	`uvm_object_utils(env_cfg)



	// Define component that are needed
	bit need_scoreboard = 0; // just for now!
	bit need_apb_agent = 1;
	bit need_uart_agent = 1;
	bit need_virtual_sequncer = 1;

	// Congiguration files for agents
	apb_cfg apb_cfg_ech;
	uart_cfg uart_cfg_ech;

	function new(string name="");
		super.new(name);
	endfunction


endclass:env_cfg


