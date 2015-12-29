import StmtFSM::*;
import GetPut::*;
import Connectable::*;
import TimekeepersLock::*;
import UART::*;

(* synthesize *)
module mkTimekeepersLockTb (Empty);
	TimekeepersLock tklock <- mkTimekeepersLock;
	UartTx gps <- mkUartTx;
	UartTx keypad <- mkUartTx;

	mkConnection(gps.wires, tklock.gps_uart);
	mkConnection(keypad.wires, tklock.keypad_uart);

	mkAutoFSM(seq
		par
			gps.tx.put(84);
			keypad.tx.put(116);
		endpar
		par
			gps.tx.put(101);
			keypad.tx.put(104);
		endpar
		par
			gps.tx.put(115);
			keypad.tx.put(105);
		endpar
		par
			gps.tx.put(116);
			keypad.tx.put(115);
		endpar
		delay(3000);
	endseq);
endmodule