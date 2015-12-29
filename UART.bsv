import TimekeepersLockGlobals::*;

interface UART;
	interface UARTWires wires;
endinterface

interface UARTWires;
	(* always_ready, always_enabled, prefix="" *)
	method Action putInBit((*port="rx"*) Bit#(1) b);
endinterface

module mkUART(UART);
	interface UARTWires wires;
		method Action putInBit(Bit#(1) b) = noAction;
	endinterface
endmodule