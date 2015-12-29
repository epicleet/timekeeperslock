BSCFLAGS=-aggressive-conditions \
	-steps-warn-interval 2000000 -steps-max-intervals 6000000 \
	-opt-undetermined-vals -unspecified-to X
BSCLIBS=keccak-bsv
BSCLFLAGS=-vdir . -bdir . -simdir . \
	-suppress-warnings S0089:S0073
SRCFILES=$(wildcard *.bsv keccak-bsv/*.bsv)

all: mkTimekeepersLock.v

mkTimekeepersLock.v: TimekeepersLock.bsv $(SRCFILES)
	bsc $(BSCFLAGS) $(BSCLFLAGS) -u -verilog -p +:$(BSCLIBS) $<

tb: TimekeepersLockTb.bsv $(SRCFILES)
	bsc $(BSCFLAGS) $(BSCLFLAGS) -u -sim -p +:$(BSCLIBS) $<
	bsc $(BSCLFLAGS) -sim -o $@ -e mkTimekeepersLockTb

clean:
	$(MAKE) -C keccak-bsv clean
	rm -f *.bo *.ba mk*.v mk*.cxx mk*.h mk*.o model_*.cxx model_*.h model_*.o
	rm -f tb tb.so