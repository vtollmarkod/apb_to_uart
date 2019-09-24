typedef enum {READ,WRITE,NONE} rw_mode;


class apb_sequence_item extends uvm_sequence_item;
	
	rand bit [31:0] paddr;
	rand bit [31:0] pwdata;
  	rand rw_mode mode;
	rand int delay;
  	rand bit [31:0] prdata; // Only using rand to constraint to 32'h0

	`uvm_object_utils_begin(apb_sequence_item)
	`uvm_field_int(paddr,UVM_ALL_ON)
	`uvm_field_int(pwdata,UVM_ALL_ON)
	`uvm_field_int(prdata,UVM_ALL_ON)
    `uvm_field_enum(rw_mode, mode, UVM_ALL_ON)
  	`uvm_field_int(delay, UVM_ALL_ON)
	`uvm_object_utils_end

  	function new (string name = "");
		super.new(name);
    endfunction


	constraint apb_sequence_item {
      	paddr inside {[1:100]};
      	prdata == 32'h0;
      	pwdata inside {[400:500]};
		delay inside {[5:10]};
	}
endclass:apb_sequence_item