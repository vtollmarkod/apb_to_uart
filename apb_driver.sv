class apb_driver extends uvm_driver #(uvm_sequence_item);
	uvm_component_utils (apb_driver)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass:apb_driver
 