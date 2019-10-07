class apb_agent extends uvm_agent;
	`uvm_component_utils(apb_agent)

	apb_driver 		apb_driver_h;
	apb_monitor 	apb_monitor_h;
	apb_sequencer 	apb_sequencer_h;
 	apb_cfg 		apb_cfg_ah;
 	//virtual apb_interface apb_interface_ah;


	function new(string name, uvm_component parent);
      super.new (name,parent); 
	endfunction

	virtual function void build_phase (uvm_phase phase);
      
      apb_monitor_h = apb_monitor::type_id::create("apb_monitor_h",this);
      
      // Get APB configuration from environment
      if(!uvm_config_db#(apb_cfg) :: get(this,"","apb_cfg_h", apb_cfg_ah)) //apb_cfg_h
        begin `uvm_fatal (get_type_name (), "Didn't get interface config_object from test") end
      
      if (apb_cfg_ah.active == UVM_ACTIVE)
        begin
      		apb_driver_h = apb_driver::type_id::create("apb_driver_h",this);
	  		apb_sequencer_h = apb_sequencer::type_id::create("apb_sequencer_h",this);
        end


      // Set virtual interface for driver,monitor
      uvm_config_db#(virtual apb_interface)::set(this,"*", "virtual_apb_interface",apb_cfg_ah.apb_interface_h);
    	
	//uvm_config_db #(int)::dump();
	endfunction

	virtual function void connect_phase (uvm_phase phase);
      apb_driver_h.seq_item_port.connect(apb_sequencer_h.seq_item_export);      
	endfunction
endclass:apb_agent
