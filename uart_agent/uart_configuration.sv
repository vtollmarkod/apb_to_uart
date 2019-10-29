class uart_cfg extends uvm_object;
  `uvm_object_utils(uart_cfg)
  
	// Interface Handle
	virtual uart_interface uart_interface_h;
  	// APB agent configuration
  	uvm_active_passive_enum    active = UVM_PASSIVE;
  	

  function new(string name="");
      super.new(name);
    endfunction
  
  
endclass:uart_cfg