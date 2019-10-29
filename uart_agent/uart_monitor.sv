class uart_monitor extends uvm_monitor;
	`uvm_component_utils (uart_monitor)

	virtual uart_interface uart_interface_h;
	uvm_analysis_port #(uart_sequence_item)  uart_monitor_analysis_port; 
	
	bit [31:0] data; // Recived data
	bit reciving_data_progres =0;
  	enum {VALID, CORRUPTED} recived_data_check;

	function new (string name, uvm_component parent= null);
    	super.new (name, parent);
	endfunction

	virtual function void build_phase (uvm_phase phase);
		super.build_phase (phase);

		uart_monitor_analysis_port = new("uart_monitor_analysis_port",this);
		if (! uvm_config_db #(virtual uart_interface) :: get (this, "", "uart_interface", uart_interface_h)) 
				begin `uvm_fatal (get_type_name (), "Didn't get handle to virtual interface apb_interface") end
    endfunction

    virtual task run_phase(uvm_phase phase);
      	uart_sequence_item uart_data = uart_sequence_item::type_id::create ("uart_data",this);
      	recived_data_check = CORRUPTED; // Just to ensure not to send data before check START and STOP bit
    	forever begin
			//Reciving data
            @(posedge uart_interface_h.tx iff reciving_data_progres == 0) // Transimition started
                begin
                    reciving_data_progres = 1; // Block reciving data

                    // Wait START bit
                        @(posedge uart_interface_h.clk)
                            begin 
                                if (uart_interface_h.tx == 0)
                                    recived_data_check=VALID;
                                else 
                                    recived_data_check=CORRUPTED;
                            end

                    // Recive bits from LSB to MSB
                        for(int i=31; i==0; i--)
                        begin
                            @(posedge uart_interface_h.clk)
                                data[i]=uart_interface_h.tx;
                        end
                    // Wait STOP bit
                        @(posedge uart_interface_h.clk)
                            begin 
                                if (uart_interface_h.tx == 1)
                                    recived_data_check=VALID;
                                else 
                                    recived_data_check=CORRUPTED;
                            end
                        if (recived_data_check == VALID)
                            uart_data.frame = data;

                        //Enable reciving data
                        reciving_data_progres = 0;
                end//posedge
        end//forever
    endtask
endclass:uart_monitor