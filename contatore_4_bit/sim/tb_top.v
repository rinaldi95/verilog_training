
`timescale 1ns/1ps
module tb_top;
    reg clk=0, rst_n=0;
    wire [3:0] led;

    // Genera il clock
    always #5 clk = ~clk;

    // Istanzia il modulo da testare (DUT = Device Under Test)
    top dut(.clk(clk), .rst_n(rst_n), .led(led));

    initial begin
        // Salva le onde (per visualizzarle in GTKWave)
        $dumpfile("build/waves.vcd");
        $dumpvars(0, tb_top);

        // Reset (3 cicli di clock)
        repeat (3) @(posedge clk);
        rst_n = 1;

        // Verifica (esegui il test per 20 cicli)
        repeat (20) @(posedge clk);

        // Stampa il risultato
        $display("TEST PASS");
        $finish;
   end
endmodule
