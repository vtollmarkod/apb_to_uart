class apb_monitor extends uvm_monitor;
	`uvm_component_utils (apb_monitor)

  	virtual apb_interface apb_interface_h;
  	uvm_analysis_port #(apb_sequence_item)   monitor_analysis_port;
  
  
	function new (string name, uvm_component parent= null);
    	super.new (name, parent);
	endfunction
  	
  virtual function void build_phase(uvm_phase phase);
		super.build_phase (phase);
    
		monitor_analysis_port = new("monitor_analysis_port",this);
		if (! uvm_config_db #(virtual apb_interface) :: get (this, "", "apb_interface", apb_interface_h)) 
			`uvm_fatal (get_type_name (), "Didn't get handle to virtual interface apb_interface")
     endfunction
          
	virtual task run_phase(uvm_phase phase);
		// Kreiraj paket pokupi sa magistrale sta treba
    apb_sequence_item  monitor_data =  apb_sequence_item::type_id::create("monitor_data",this);
    forever begin
			// Get Signal
      @(posedge apb_interface_h.clk iff !apb_interface_h.rst)
        if(apb_interface_h.psel && apb_interface_h.penable && apb_interface_h.pready)
        begin
          if(apb_interface_h.pwrite) // WRITE
            begin
              monitor_data.pwdata <= apb_interface_h.pwdata;
              monitor_data.paddr <= apb_interface_h.paddr;
              monitor_data.mode <= WRITE;
              monitor_data.print();`uvm_info(get_type_name(), "MONITOR WRITE", UVM_LOW)
            end
          if(!apb_interface_h.pwrite) // READ
            begin
              monitor_data.prdata <= apb_interface_h.prdata;
              monitor_data.paddr <= apb_interface_h.paddr;
              monitor_data.mode <= READ;
              monitor_data.print();`uvm_info(get_type_name(), "MONITOR READ", UVM_LOW)
            end
        end
    end//forever
  endtask


  
  
endclass:apb_monitor