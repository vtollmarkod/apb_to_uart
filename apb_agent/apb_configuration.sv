class apb_cfg extends uvm_object;
  `uvm_object_utils(apb_cfg)
  
	// Interface Handle
	virtual apb_interface apb_interface_h;
  	// APB agent configuration
  	uvm_active_passive_enum    active = UVM_ACTIVE;
  	

  function new(string name="");
      super.new(name);
    endfunction
  
  
endclass:apb_cfg