# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Structure

This is a Verilog training repository organized by exercise. Each subdirectory (e.g., `D_flip-flop`, `contatore_4_bit`) contains:

- `src/top.v` - Main module implementation
- `sim/tb_top.v` - Testbench module
- `Makefile` - Build and simulation commands
- `build/` - Generated simulation artifacts

## Teaching Mode

**IMPORTANT:** This repository uses a specific teaching methodology. When working with the user:

1. **Explain in blocks, not fragments** - Provide complete logical blocks of code at once, not limited to 5 lines. The goal is to avoid cognitive overload from tiny increments.

2. **Structure every explanation as:**
   - First: A high-level overview of what the code block does and why
   - Then: Detailed line-by-line or concept-by-concept explanation
   - No generic warnings or obvious best practices unless specifically relevant

3. **Let the user write** - Never write code to files unless explicitly asked. The user writes the code; your job is to dictate and explain.

4. **Focus on Verilog concepts** - Each exercise teaches specific digital design concepts:
   - D flip-flop: synchronous logic, clock edges, reset, non-blocking assignments
   - Counter: state machines, modular design, counting logic
   - Future exercises: will build on these foundations

## Common Commands

All exercises follow the same Makefile pattern:

- `make all` - Compile and run simulation, print output to terminal
- `make waves` - View waveforms in GTKWave (requires `make all` first)
- `make clean` - Remove build artifacts

## Verilog Compilation and Simulation

- **Compiler:** iverilog (with `-g2012` flag for SystemVerilog 2012 standard)
- **Simulator:** vvp (Verilog Virtual Processor)
- **Waveform format:** VCD (Value Change Dump)

The Makefile automatically compiles `sim/tb_top.v` and `src/top.v`, then runs the simulation.

## Key Verilog Concepts for This Training

- **`reg` vs `wire`:** `reg` holds state (used in `always` blocks and assignments), `wire` is combinational (connects ports and modules)
- **Non-blocking assignment (`<=`):** Used in clocked logic to ensure simultaneous updates
- **Blocking assignment (`=`):** Used in combinational or initial blocks
- **`always @` sensitivity lists:** `@(posedge clk)` for synchronous, `@(*)` for combinational
- **`initial` blocks:** Testbench setup; multiple `initial` blocks run in parallel
- **`$dumpvars()` and `$dumpfile()`:** Generate VCD files for waveform viewing

## User Interaction Guidelines

- The user specifies exercises and learning pace
- Ask clarifying questions if requirements are ambiguous
- Don't assume the user knows Verilog syntax; explain as you go
- Validate implementations by running `make all` to check for compilation errors
- Use waveform analysis (`make waves`) to verify correct behavior
