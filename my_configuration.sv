class my_configuration extends uvm_object;
	`uvm_object_utils (my_configuration)

  	function new (string name = "");
		super.new(name);
    endfunction

	// Declaration of virtual interface
	virtual my_interface my_interface_h;

endclass:my_configuration

/* ==================================
Ovo sam trebao da uradim na sledeci nacin:name
1. Podeliti interface sa modport na APB i UART delove.
2. Onda napraviti dva konfugraciona fajla jedan koji podesava
   APB da bude aktivan i taj deo sadrzi APB deo interfejsa, 
   isto uraditi i za UART deo

Tako mogu da nezavisno hendlujem agente sa konfiguracioni fajlom.
Obzirom da imam samo jedan interfejs u konfiguracionom fajlu prosledjujem 
samo virtuelni interfejs kako. 
http://www.learnuvmverification.com/index.php/2015/07/22/uvm-configuration-object-concept/
https://www.chipverify.com/blog/how-to-turn-an-agent-from-active-to-passive
*/