import Keccak::*;
import UART::*;

interface TimekeepersLock;
	interface UARTWires gps_uart;
	interface UARTWires keypad_uart;
endinterface

(* synthesize *)
module mkTimekeepersLock(TimekeepersLock);
	UART gps <- mkUART;
	UART keypad <- mkUART;

	interface gps_uart = gps.wires;
	interface keypad_uart = keypad.wires;
endmodule