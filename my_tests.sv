class apb_write_test extends uvm_test;
	`uvm_component_utils(apb_write_test)

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
		apb_write_sequence seq;
    	seq = apb_write_sequence::type_id::create("seq");
    	phase.raise_objection(this);
    	seq.start (my_enviroment_h.apb_agent_h.apb_sequencer_h);
    	phase.drop_objection(this);
    endtask
endclass:apb_write_test


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

