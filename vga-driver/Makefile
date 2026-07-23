PROJ    = top
PIN_DEF = icebreaker.pcf
DEVICE  = up5k
PACKAGE = sg48
SRC = top.v vga.v pll.v

all: $(PROJ).bin

# Synthesis
$(PROJ).json: $(SRC)
	yosys -p "synth_ice40 -top $(PROJ) -json $@" $(SRC)

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
sim: vga_tb.v vga.v
	iverilog -o vga_tb vga_tb.v vga.v
	vvp vga_tb -fst
	surfer vga_tb.fst

clean:
	rm -f $(PROJ).json $(PROJ).asc $(PROJ).bin $(PROJ).rpt \
		$(PROJ)_tb $(PROJ).fst

.PHONY: all prog time sim clean
