class uart_monitor extends uvm_monitor;
	`uvm_component_utils (uart_monitor)

	virtual uart_interface uart_interface_h;
	uvm_analysis_port #(uart_sequence_item)  uart_analysis_port; 
	
	int data_lenght=30; // Koliko sistemskih klokova traje simbol
	bit data[7:0]; // Recived data
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
            @(posedge uart_interface.tx iff reciving_data_progres = 0) // Transimition started
                begin
                    reciving_data_progres = 1; // Block reciving data

                    // Wait START bit
                    repeat(data_lenght/2) 
                        @(posedge uart_interface.clk)
                    // Sample DATA bits MSB -> LSB
                    for (int i=0 ; i<8 ; i++)
                        begin
                            repeat(data_lenght)
                                @(posedge uart_interface_h.clk) // ==== Proveriti ovaj deo !
                        data[i] = uart_interface_h.tx; 
                        end
                    // Wait STOP bit
                    repeat(data_lenght)
                        @(posedge uart_interface_h.clk)

                    // STOP bit is 1, now it is safe to enable detecting new START bit
                    uart_data.frame = data;
                    reciving_data_progres = 0;
                end
    		
        end//forever
    endtask
endclass:uart_monitor

/*


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
                reciving_data_progres = 0;
            end//posedge
*/