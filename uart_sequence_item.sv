
class uart_sequence_item extends uvm_sequence_item;
	 bit [7:0] frame;

  	function new (string name = "");
		super.new(name);
    endfunction

	`uvm_object_utils_begin(uart_sequence_item)
	`uvm_field_int(frame,UVM_ALL_ON)
	`uvm_object_utils_end

endclass:uart_sequence_item