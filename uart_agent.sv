class uart_agent extends uvm_agent;
	`uvm_component_utils(uart_agent)

	uart_monitor uart_monitor_h;

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uart_monitor_h = uart_monitor::type_id::create("uart_monitor_h",this);
	endfunction
endclass:uart_agent