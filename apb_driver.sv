class apb_driver extends uvm_driver #(uvm_sequence_item);
	uvm_component_utils (apb_driver)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	//TODO interface, build phase




	task run_phase (uvm_phase phase);
		forever begin
			apb_sequence_item data;
			@(posedge TODO CLOCK);
				seq_item_port.get_next_item(data);
				









				seq_item_port.item_done();



		end//forever
	endtask:run_phase



endclass:apb_driver
 