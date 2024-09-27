`include "./top.v"
module toptb;

// Señales de prueba
reg [6:0] bin_in;         // Entrada: número binario de 7 bits (0-99)
reg clk;                  // Señal de reloj
wire [6:0] seg_out;       // Salida: segmentos para el display de 7 segmentos
wire [3:0] sel;           // Selección del display

// Instancia del módulo top
top dut (
    .bin_in(bin_in),
    .clk(clk),
    .seg_out(seg_out),
    .sel(sel)
);

// Generador de reloj (simulación a 50 MHz, periodo de 20 ns)
initial begin
    clk = 0;
    forever #10 clk = ~clk; // Alterna cada 10 ns (20 ns de periodo)
end

// Estimulación de las señales de entrada
initial begin
    // Establecer un valor inicial
    bin_in = 7'd0;  // 0 en binario
    
    // Esperar un ciclo completo para observar el comportamiento inicial
    #200;

    // Cambiar el valor binario a diferentes números
    bin_in = 7'd15;  // Cambia el valor a 15 (ver decenas y unidades)
    #200;
    
    bin_in = 7'd42;  // Cambia el valor a 42
    #200;
    
    bin_in = 7'd99;  // Cambia el valor a 99 (máximo valor)
    #200;
    
    bin_in = 7'd5;   // Cambia el valor a 5
    #200;

    // Finalizar simulación
    $stop;
end

// Monitoreo de las salidas
initial begin
    $monitor("Time = %0t | bin_in = %d | seg_out = %b | sel = %b", 
              $time, bin_in, seg_out, sel);
end

endmodule
