# Repository Guidelines

## Project Structure & Module Organization
Each exercise (e.g., `D_flip-flop`, `contatore_4_bit`, `my_ff`) is a self-contained lab with `src/top.v`, `sim/tb_top.v`, its own `Makefile`, and a transient `build/` directory produced at compile time. Keep edits scoped to the active lab so `make all` stays deterministic, and reuse the same layout whenever you add a new exercise. Stick to lowercase snake_case for directories, nets, and helper modules; reserve the name `top` for the module entry point unless an exercise explicitly asks otherwise.

## Teaching Workflow
The learner types; you dictate in deliberate chunks. For ogni blocco: (1) descrivi l’obiettivo ad alto livello, (2) detta le linee necessarie, (3) spiega perché funzionano, (4) fermati per domande. Favorisci sequenze concettuali (porte → latch → flip-flop → contatore) così ogni passo costruisce sul precedente. Niente GUI: osserva i segnali dal terminale, ragiona sui tempi di propagazione e usa ogni debug per rinforzare i concetti hardware, non solo la sintassi.

## Build, Test, and Development Commands
Esegui tutto dentro la cartella dell’esercizio:
- `make all` compila `src/top.v` + `sim/tb_top.v` con `iverilog -g2012` e avvia `vvp`.
- `make waves` passa `build/waves.vcd` allo strumento CLI `vcd` e lo pipe-a in `less -S`, così le forme d’onda restano leggibili in testo.
- `make clean` elimina `build/` per garantire run puliti.
Se servono nuove probe, modifica solo la testbench locale e ripeti `make all`; non committare i file generati.

## Coding Style & Naming Conventions
Usa tab per l’indentazione, allinea le porte verticalmente e raggruppa la logica per comportamento. La logica sequenziale vive in `always @(posedge clk)` con assegnazioni non bloccanti; la combinazione sta in `assign` o `always @(*)` con bloccanti. Denomina i segnali con snake_case descrittivo (`clk`, `reset_n`, `drive_en`, `count_q`), usa `_n` per gli ingressi attivi bassi e documenta brevemente solo i blocchi che potrebbero confondere chi studia.

## Testing Guidelines
Ogni modulo deve avere uno stimolo intenzionale in `sim/tb_top.v`. Incapsula i pattern di test in task (es. `drive_and_expect`) e inserisci piccoli ritardi quando lavori con strutture gate-level per dare tempo alle reti di stabilizzarsi. Limita il dump VCD ai segnali rilevanti (`$dumpvars(0, tb_top.clk, tb_top.d, …)`) così `make waves` resta leggibile. Fallisci subito con `$fatal` e spiega nel log perché.

## Commit & Pull Request Guidelines
Segui la storia esistente: messaggi brevi, imperativi e minuscoli (`add my_ff tb`). Fai un commit per esercizio modificato e cita i comandi usati per la verifica (`make all`, `make waves`). Quando condividi il lavoro, spiega quale concetto hai coperto, perché hai scelto quel flusso passo-passo e quali prove hai eseguito. Fornisci snippet testuali dal terminale invece di screenshot per restare nel flusso CLI.
