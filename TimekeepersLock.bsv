import GetPut::*;
import Connectable::*;
import GetPut::*;
import ClientServer::*;
import Keccak::*;
import UART::*;
import NmeaReader::*;

interface TimekeepersLock;
	(* always_ready *)
	method Bool open_lock;
	interface UartRxWires gps_uart;
	interface UartRxWires keypad_uart;
endinterface

(* synthesize *)
module mkTimekeepersLock(TimekeepersLock);
	let gps <- mkUartRx;
	let keypad <- mkUartRx;
	let nmea <- mkNmeaReader;

	mkConnection(gps.rx, nmea.request);

	rule read_gps;
		let x <- nmea.response.get;
		$display("response: ", fshow(x));
	endrule

	rule read_keypad;
		let x <- keypad.rx.get;
		//$display("Keypad: %h", x);
	endrule

	method Bool open_lock = False;

	interface gps_uart = gps.wires;
	interface keypad_uart = keypad.wires;
endmodule