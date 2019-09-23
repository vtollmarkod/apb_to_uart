class apb_write_test extends uvm_test;
	`uvm_component_utils(apb_write_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	// Define enviroment
	my_enviroment my_enviroment_h;

	// Define configuration object
	//my_configuration my_configuration_h; // ==================== iskoristiti kada se podeli interface na apb i uart

	function void build_phase(uvm_phase phase);
		my_enviroment_h = my_enviroment::type_id::create("my_enviroment_h", this);
		//my_configuration_h = my_configuration::type_id::create("my_configuration_h", this);
		//uvm_config_db #(my_configuration)::set(this,"m_top_env.my_agent","my_configuration_h",my_configuration_h)
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


// ==================== Pogledati Sequence and Test kako se pokrece sekvenca sekvenci, tu me buni sekvencer
// Kao da gazi putanju sekvencer, progooglati ovaj deo !!!


class apb_read_test extends uvm_test;
	`uvm_component_utils(apb_read_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	// Define enviroment
	my_enviroment my_enviroment_h;

	// Define configuration object
	//my_configuration my_configuration_h; // ==================== iskoristiti kada se podeli interface na apb i uart

	function void build_phase(uvm_phase phase);
		my_enviroment_h = my_enviroment::type_id::create("my_enviroment_h", this);
		//my_configuration_h = my_configuration::type_id::create("my_configuration_h", this);
		//uvm_config_db #(my_configuration)::set(this,"m_top_env.my_agent","my_configuration_h",my_configuration_h)
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