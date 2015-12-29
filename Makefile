BSCFLAGS=-aggressive-conditions \
	-steps-warn-interval 2000000 -steps-max-intervals 6000000 \
	-opt-undetermined-vals -unspecified-to X
BSCLIBS=keccak-bsv
SRCFILES=$(wildcard *.bsv keccak-bsv/*.bsv)

all: mkTimekeepersLock.v

mkTimekeepersLock.v: TimekeepersLock.bsv $(SRCFILES)
	bsc $(BSCFLAGS) -u -verilog -p $(BSCLIBS):+ $<

clean:
	rm -f *.bo *.ba mk*.v mk*.cxx mk*.h mk*.o model_*.cxx model_*.h model_*.o
	rm -f tb tb.so
	rm -f test_vectors/*_out.txt
