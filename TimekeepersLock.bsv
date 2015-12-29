import GetPut::*;
import Connectable::*;
import ClientServer::*;
import UART::*;
import NmeaReader::*;
import HashProvider::*;

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
	let prov <- mkHashProvider;

	mkConnection(gps.rx, nmea.request);
	mkConnection(nmea.response, prov.info);

	rule read_keypad;
		let x <- keypad.rx.get;
		//$display("Keypad: %h", x);
	endrule

	method Bool open_lock = False;

	interface gps_uart = gps.wires;
	interface keypad_uart = keypad.wires;
endmodule