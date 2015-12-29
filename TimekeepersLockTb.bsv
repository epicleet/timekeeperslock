import StmtFSM::*;
import GetPut::*;
import Connectable::*;
import List::*;
import TimekeepersLock::*;
import TimekeepersLockGlobals::*;
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
			sendStr(gps, "$GPRMC,092750.000,A,5321.6802,N,00630.3372,W,0.02,31.66,280511,,,A*43");
			sendStr(keypad, "A7FFC6F8BF1ED76651C14756A061D662F580FF4DE43B49FA82D80A4B80F8434A");
		endpar
		delay(3000);
	endseq);
endmodule

function Stmt sendStr(UartTx u, String s);
	List#(Byte) bytelist = map(fromInteger, map(charToInteger, stringToCharList(s)));
	function compose_seq(cur_seq, b) = seq cur_seq; u.tx.put(b); endseq;
	return foldl(compose_seq, seq endseq, bytelist);
endfunction