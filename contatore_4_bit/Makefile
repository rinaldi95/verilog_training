TOP=top

.PHONY: all waves clean
all:
  build/sim.vvp

build:
	mkdir -p build

build/sim.vvp:
  sim/tb_$(TOP).v src/$(TOP).v | build
	iverilog -g2012 -o
  build/sim.vvp sim/tb_$(TOP).v src/$(TOP).v
	vvp
  build/sim.vvp

waves: build/sim.vvp
	gtkwave build/waves.vcd
  &

clean:
	rm -rf build/*
