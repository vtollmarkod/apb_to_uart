typedef enum {READ,WRITE} rw_mode;
 

class apb_sequence_item extends uvm_sequence_item;
	rand bit [31:0] paddr;
	rand bit [31:0] prdata;
	rand bit [31:0] pwdata;
	rand bit pwrite;
	rand bit psel;
	rand bit penable;
	rand bit pready;
	rand bit pslverr; 
	rand int delay;
	rand rw_mode mode;

		
	`uvm_object_utils (apb_sequence_item)
	`uvm_field_int(paddr,UVM_DEFAULT)
	`uvm_field_int(pwdata,UVM_DEFAULT)
	`uvm_field_int(prdata,UVM_DEFAULT)
	`uvm_field_int(pwrite,UVM_DEFAULT)
	`uvm_field_int(psel,UVM_DEFAULT)
	`uvm_field_int(penable, UVM_DEFAULT)
	`uvm_field_int(pready, UVM_DEFAULT)
	`uvm_field_int(pslverr, UVM_DEFAULT)
	`uvm_field_int(delay, UVM_DEFAULT)

	function new (string name = "");
      super.new(name);
    endfunction

	constraint apb_sequence_item {
		paddr inside {[1:500]};
		pdata inside {[600:900]}; 
		delay inside {[1:10]};
	}
endclass:apb_sequence_item