import StmtFSM::*;
import GetPut::*;
import Connectable::*;
import List::*;
import TimekeepersLock::*;
import TimekeepersLockGlobals::*;
import UART::*;

(* synthesize *)
module mkTimekeepersLockTb (Empty);
	let tklock <- mkTimekeepersLock;
	let gps <- mkUartTx;
	let keypad <- mkUartTx;

	Reg#(Bit#(32)) i <- mkReg(0);
	Reg#(Bit#(32)) j <- mkReg(0);

	mkConnection(gps.wires, tklock.gps_uart);
	mkConnection(keypad.wires, tklock.keypad_uart);

	mkAutoFSM(seq
		par
			sendStr(i, gps, "$GPRMC,092750.000,A,5321.6802,N,00630.3372,W,0.02,31.66,280511,,,A*43");
			sendStr(j, keypad, "A7FFC6F8BF1ED76651C14756A061D662F580FF4DE43B49FA82D80A4B80F8434A");
		endpar
		delay(3360);
		$display("door unlocked? ", fshow(tklock.open_lock));
	endseq);
endmodule

function Stmt sendStr(Reg#(Bit#(32)) i, UartTx u, String s);
	List#(Byte) bytelist = map(fromInteger, map(charToInteger, stringToCharList(s)));
	return seq
		i <= 0;
		while (i < fromInteger(stringLength(s))) action
			u.tx.put(bytelist[i]);
			i <= i + 1;
		endaction
	endseq;
endfunction