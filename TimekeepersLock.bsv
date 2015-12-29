import Keccak::*;
import UART::*;

interface TimekeepersLock;
	(* always_ready *)
	method Bool open_lock;
	interface UARTWires gps_uart;
	interface UARTWires keypad_uart;
endinterface

(* synthesize *)
module mkTimekeepersLock(TimekeepersLock);
	UART gps <- mkUART;
	UART keypad <- mkUART;

	method Bool open_lock = False;

	interface gps_uart = gps.wires;
	interface keypad_uart = keypad.wires;
endmodule