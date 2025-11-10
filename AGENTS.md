# Repository Guidelines

## Project Structure & Module Organization
Each exercise lives in its own directory (e.g., `D_flip-flop`, `contatore_4_bit`) and carries a consistent layout: implementation under `src/top.v`, testbench under `sim/tb_top.v`, a local `Makefile`, and a `build/` folder for generated artifacts. Treat every directory as an isolated lab; keep changes scoped so you can simulate without affecting other exercises. Module names and filenames follow lowercase snake_case (except the canonical `top` entry point), so match that pattern when adding new designs.

## Build, Test, and Development Commands
Run commands from within the target exercise folder:
- `make all` — compile `src/top.v` and `sim/tb_top.v` with iverilog (`-g2012`), then launch the vvp simulation and print console output.
- `make waves` — open GTKWave on `build/top.vcd`; call `make all` first so the dump exists.
- `make clean` — remove everything under `build/` to guarantee a fresh compile.
If you need to probe internal nets, instrument the testbench and rerun `make all`.

## Coding Style & Naming Conventions
Use tabs for indentation and keep ports aligned vertically for readability, as shown in `D_flip-flop/src/top.v`. Clocked logic lives in `always @(posedge clk …)` blocks with non-blocking assignments (`<=`), while combinational glue uses `assign` or `always @(*)` with blocking `=`. Default to descriptive lower_snake_case signal names (`clk`, `reset_n`, `count_q`). Limit each module to one responsibility and document any non-obvious sequences with a short comment above the block.

## Testing Guidelines
Every feature needs a matching stimulus in `sim/tb_top.v`. Name testbench tasks after the behavior they check (e.g., `task drive_reset;`). Use `$dumpfile("build/top.vcd")` and `$dumpvars(0, tb_top);` so `make waves` always has data. Keep assertions simple (`$fatal` on mismatch) because iverilog runs fast and gives immediate feedback. Before submitting, run `make all` for every exercise you touched and ensure there are no warnings.

## Commit & Pull Request Guidelines
Existing history favors short, imperative summaries (`flip flop`, `Initial commit`). Follow that style: start with a lowercase verb, describe the scope, and keep it under ~60 characters. For multi-directory updates, prefer separate commits per exercise. Pull requests (or shared diffs) should include: what changed, why it was needed, how you validated it (`make all`, waveform inspection), and any follow-up work. Attach waveform screenshots or log snippets when behavior is the main focus.
