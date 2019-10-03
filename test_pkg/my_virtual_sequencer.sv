class my_virtual_sequencer extends uvm_sequencer;
	`uvm_component_utils (my_virtual_sequencer)
    
    apb_sequencer apb_sequencer_h;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  
endclass:my_virtual_sequencer