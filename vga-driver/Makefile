PROJ    = top
PIN_DEF = icebreaker.pcf
DEVICE  = up5k
PACKAGE = sg48
SRC = top.v pixel_gen.v vga_timing.v pll.v
TB = vga_timing
CELLS = $(shell yosys-config --datdir)/ice40/cells_sim.v

all: $(PROJ).bin

# Linting
lint: verilator.vlt $(SRC)
	verilator --lint-only -Wall --top-module top verilator.vlt $(SRC) $(CELLS)
	iverilog -Wall -g2012 -o /dev/null -s top $(SRC) $(CELLS)

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
sim: $(TB)_tb.v $(TB).v
	iverilog -o $(TB)_tb.vvp $(TB)_tb.v $(TB).v
	vvp $(TB)_tb.vvp -fst
	surfer $(TB)_tb.fst

clean:
	rm -f $(PROJ).json $(PROJ).asc $(PROJ).bin $(PROJ).rpt \
		*.vvp *.fst *.vcd

.PHONY: all prog time sim lint clean
