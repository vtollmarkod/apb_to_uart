class my_virtual_sequence extends uvm_sequence;
	`uvm_object_utils (my_virtual_sequence)
  `uvm_declare_p_sequencer (my_virtual_sequencer)

  function new (string name = "");
    super.new(name);
  endfunction
  
  
  apb_read_sequence 	apb_read_sequence_vh;
  apb_write_sequence	apb_write_sequence_vh;


  task pre_body();
  	apb_read_sequence_vh = apb_read_sequence::type_id::create("apb_read_sequence_vh");
  	apb_write_sequence_vh = apb_write_sequence::type_id::create("apb_write_sequence_vh");
  endtask

  // A handle called p_sequencer is created within the sequence via macro `uvm_declare_p_sequencer 
  // and assigned to be run with my_virtual_sequencer

  task body();
    repeat(6)
      apb_write_sequence_vh.start(p_sequencer.apb_sequencer_h);
  endtask

endclass:my_virtual_sequence