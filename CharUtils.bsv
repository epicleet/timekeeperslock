import TimekeepersLockGlobals::*;

function Byte ord(String s) = fromInteger(charToInteger(stringHead(s)));

function Byte lowercase(Byte c) = c | 'h20;

function Bit#(4) conv_dig(Byte c);
	Byte lc = lowercase(c);
	return pack(
			(c  >= ord("0") && c  <= ord("9")) ? (c  - ord("0")) :
			(lc >= ord("a") && lc <= ord("f")) ? (lc - ord("a") + 10) :
			(?)
	)[3:0];
endfunction