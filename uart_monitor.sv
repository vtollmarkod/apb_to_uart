class uart_monitor extends uvm_monitor;
	`uvm_component_utils (uart_monitor)

	virtual uart_interface uart_interface_h;
	uvm_analysis_port #(uart_sequence_item)  uart_analysis_port; 
	
	int data_lenght=30; // Koliko sistemskih klokova traje simbol
	bit data[7:0]; // Recived data
	bit buffer[299:0]; // Velicni buffera je 10*data_lenght
	bit reciving_data_progres =0;	

	function new (string name, uvm_component parent= null);
    	super.new (name, parent);
	endfunction

	virtual function void build phase (uvm_phase phase);
		super.build_phase (phase)

			uart_monitor_analysis_port = new("uart_monitor_analysis_port",this);
			if (! uvm_config_db #(virtual uart_interface) :: get (this, "", "uart_interface", uart_interface_h)) 
				begin `uvm_fatal (get_type_name (), "Didn't get handle to virtual interface apb_interface") end
    endfunction

    virtual task run_phase(uvm_phase phase)
    	uart_sequence_item uart_data = uart_sequence_item::type_id::create ("uart_data",this);
    	forever begin
			//Reciving data
    		@(posedge uart_interface_h.tx iff reciving_data_progres == 0) //Detected START bit
    		begin
    			reciving_data_progres = 1;
    			for(int i=0; i<10*data_lenght; i++) // STOP 8 START
    				@(posedge uart_interface_h.uart_clk)
    	 				buffer[i] <= uart_interface_h.tx;
                //  |---START---|---BIT 0:7---|---STOP---|
                for(int i=(1.5*data_lenght) ; i<(8.5*data_lenght) ; i=i+data_lenght)
                    for (int v=0;v<=7;v++)
                        data[v] = buffer[i];
                uart_data.frame = data;
            end//posedge
        end//forewer
    endtask
endclass:uart_monitor


    			











                reciving_data_progres = 0;
    		end








 







    	end//forewer
    endtask