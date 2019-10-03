class apb_base_test extends uvm_test; // class my_test extends uvm_test;
	`uvm_component_utils(apb_base_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	// Define enviroment
	my_enviroment my_enviroment_h;
  	// Create APB configuration object
  	apb_cfg apb_cfg_h;     

	virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
		
		my_enviroment_h = my_enviroment::type_id::create("my_enviroment_h", this);
        apb_cfg_h = apb_cfg::type_id::create("apb_cfg_h"); 

      // Get virtual interface from testbench
      if(!uvm_config_db #(virtual apb_interface)::get(this,"","apb_interface",apb_cfg_h.apb_interface_h))
        begin `uvm_fatal (get_type_name (), "Didn't get interface handle from testbench") end

      // Set configuration object to agent and other subcomponents
      uvm_config_db #(apb_cfg)::set(this,"my_enviroment_h.apb_agent_h*","apb_agent_cfg_h", apb_cfg_h); //my_enviroment_h.apb_agent ZASTO OVDE NE IDE APB_AGENT?????? PODESIO SAM DA SVI SISPOD AGENTA VIDE CONFIG
	endfunction

	virtual function void end_of_elaboration_phase (uvm_phase phase);
         uvm_top.print_topology ();
     
    endfunction

    
endclass:apb_base_test


class apb_write_test extends apb_base_test;
	`uvm_component_utils(apb_write_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		apb_write_sequence seq;
    	seq = apb_write_sequence::type_id::create("seq");
    	phase.raise_objection(this);
    	seq.start (my_enviroment_h.apb_agent_h.apb_sequencer_h);
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