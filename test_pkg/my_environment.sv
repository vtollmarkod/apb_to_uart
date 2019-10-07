class my_enviroment extends uvm_env;
	`uvm_component_utils (my_enviroment)


  
  env_cfg env_cfg_h; 
  apb_cfg apb_cfg_h;
  uart_cfg uart_cfg_h;

	my_virtual_sequencer virtual_sequencer_h;
	apb_agent apb_agent_h;
  uart_agent uart_agent_h;

	function new(string name , uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);

    // get environmet config from test
    if(!uvm_config_db#(env_cfg) :: get(this,"","env_cfg_th", env_cfg_h))
        begin `uvm_fatal (get_type_name (), "Didn't get environment config_object from test") end

    if (env_cfg_h.need_apb_agent)
        apb_agent_h = apb_agent::type_id::create("apb_agent_h",this);

    if (env_cfg_h.need_uart_agent)
        uart_agent_h = uart_agent::type_id::create("uart_agent_h",this);
      	
    if (env_cfg_h.need_virtual_sequncer)
        virtual_sequencer_h = my_virtual_sequencer::type_id::create("virtual_sequencer_h",this);
    // TODO SCOREBOARD

    // Link env_cfg to individual agents
    apb_cfg_h = env_cfg_h.apb_cfg_ech;
    uart_cfg_h = env_cfg_h.uart_cfg_ech;

    // Set configuration files for agents
    uvm_config_db#(apb_cfg):: set(this,"apb_agent_h" ,"apb_cfg_h" ,apb_cfg_h);
    uvm_config_db#(uart_cfg)::set(this,"uart_agent_h","uart_cfg_h", uart_cfg_h);
	endfunction

  
  	virtual function void connect_phase (uvm_phase phase);
  		virtual_sequencer_h.apb_sequencer_h = apb_agent_h.apb_sequencer_h;
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



