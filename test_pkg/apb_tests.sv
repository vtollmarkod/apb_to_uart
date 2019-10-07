class apb_base_test extends uvm_test; // class my_test extends uvm_test;
	`uvm_component_utils(apb_base_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	// Define enviroment
	my_enviroment my_enviroment_h;

	// Configuration objects
	env_cfg 	env_cfg_th;
  	apb_cfg 	apb_cfg_th; 
  	uart_cfg 	uart_cfg_th;


	virtual function void build_phase (uvm_phase phase);//cookbook 51	

      super.build_phase (phase);
		// Create environment
		my_enviroment_h = my_enviroment::type_id::create("my_enviroment_h", this);
		
		// Create configuration objects
        env_cfg_th  =  env_cfg::type_id::create("env_cfg_th");
        apb_cfg_th  =  apb_cfg::type_id::create("apb_cfg_th"); 
        uart_cfg_th = uart_cfg::type_id::create("uart_cfg_th");

      // Get APB virtual interface from testbench
      if(!uvm_config_db #(virtual apb_interface)::get(this,"","apb_interface", apb_cfg_th.apb_interface_h))
        begin `uvm_fatal (get_type_name (), "Didn't get APB interface handle from testbench") end

      // Get UART virtual interface from testbench
      if(!uvm_config_db #(virtual uart_interface)::get(this,"","uart_interface",uart_cfg_th.uart_interface_h))
        begin `uvm_fatal (get_type_name (), "Didn't get UART interface handle from testbench") end

		env_cfg_th.apb_cfg_ech = apb_cfg_th;
		env_cfg_th.uart_cfg_ech = uart_cfg_th;

      // Set environment congfiguration object in database
		uvm_config_db#(env_cfg)::set(this, "my_enviroment_h", "env_cfg_th", env_cfg_th);
	endfunction


	virtual function void end_of_elaboration_phase (uvm_phase phase);
         uvm_top.print_topology ();
    endfunction 

endclass:apb_base_test


class apb_write_test extends apb_base_test;
	`uvm_component_utils(apb_write_test)

	my_virtual_sequence v_seq;

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
    	v_seq = my_virtual_sequence::type_id::create("v_seq");
    	phase.raise_objection(this);
    	v_seq.start(my_enviroment_h.virtual_sequencer_h);
    	phase.drop_objection(this);
    endtask

endclass:apb_write_test 


/*

// -------------------------------- OTHER TESTS -----------------------------

class apb_read_test extends uvm_test;
	`uvm_component_utils(apb_read_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	// Define enviroment
	my_enviroment my_enviroment_h;

	function void build_phase(uvm_phase phase);
		my_enviroment_h = my_enviroment::type_id::create("my_enviroment_h", this);
	endfunction


	virtual function void end_of_elaboration_phase (uvm_phase phase);
         uvm_top.print_topology ();
    endfunction

    virtual task run_phase(uvm_phase phase);
		apb_read_sequence seq;
    	seq = apb_read_sequence::type_id::create("seq");
    	phase.raise_objection(this);
    	seq.start (my_enviroment_h.apb_agent_h.apb_sequencer_h);
    	phase.drop_objection(this);
    endtask
endclass:apb_read_test


class apb_read_write_test extends uvm_test;
	`uvm_component_utils(apb_read_write_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	my_enviroment my_enviroment_h;

	function void build_phase(uvm_phase phase);
		my_enviroment_h = my_enviroment::type_id::create("my_enviroment_h", this);
	endfunction

	virtual function void end_of_elaboration_phase (uvm_phase phase);
         uvm_top.print_topology ();
    endfunction

    virtual task run_phase(uvm_phase phase);
		apb_read_write_sequence seq;
		seq = apb_read_write_sequence::type_id::create("seq");
            if( !seq.randomize())
                  `uvm_error("", "Randomize failed")
    	phase.raise_objection(this);
    	seq.start (my_enviroment_h.apb_agent_h.apb_sequencer_h);
    	phase.drop_objection(this);
    endtask

endclass:apb_read_write_test

*/