import GetPut::*;
import Keccak::*;
import UART::*;

interface TimekeepersLock;
	(* always_ready *)
	method Bool open_lock;
	interface UartRxWires gps_uart;
	interface UartRxWires keypad_uart;
endinterface

(* synthesize *)
module mkTimekeepersLock(TimekeepersLock);
	UartRx gps <- mkUartRx;
	UartRx keypad <- mkUartRx;

	rule read_gps;
		let x <- gps.rx.get;
		$display("GPS: %h", x);
	endrule

	rule read_keypad;
		let x <- keypad.rx.get;
		$display("Keypad: %h", x);
	endrule

	method Bool open_lock = False;

	interface gps_uart = gps.wires;
	interface keypad_uart = keypad.wires;
endmodule