PROJ    = counter7seg
PIN_DEF = icebreaker.pcf
DEVICE  = up5k
PACKAGE = sg48

all: $(PROJ).bin

# Synthesis
$(PROJ).json: $(PROJ).v
	yosys -p "synth_ice40 -top $(PROJ) -json $@" $<

# Place & route
$(PROJ).asc: $(PROJ).json $(PIN_DEF)
	nextpnr-ice40 --$(DEVICE) --package $(PACKAGE) \
		--json $(PROJ).json --pcf $(PIN_DEF) --asc $@

# Pack bitstream
$(PROJ).bin: $(PROJ).asc
	icepack $< $@

# Program the board (SRAM)
prog: $(PROJ).bin
	iceprog $<

# Timing report
time: $(PROJ).asc
	icetime -d $(DEVICE) -mtr $(PROJ).rpt $<

# Simulation
sim: $(PROJ)_tb.v $(PROJ).v
	iverilog -o $(PROJ)_tb.vvp $(PROJ)_tb.v $(PROJ).v
	vvp $(PROJ)_tb.vvp
	gtkwave $(PROJ).vcd

clean:
	rm -f $(PROJ).json $(PROJ).asc $(PROJ).bin $(PROJ).rpt \
		$(PROJ)_tb.vvp $(PROJ).vcd

.PHONY: all prog time sim clean
