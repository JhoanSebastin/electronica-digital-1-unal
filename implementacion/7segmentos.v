module top (
    input wire [6:0] bin_in,          // Entrada: número binario de 7 bits (0-99)
    input clk,                   // Señal de reloj
    output reg [6:0] seg_out,    // Salida: segmentos para el display de 7 segmentos
    output reg [3:0] sel         // Selección del display (para alternar entre D1 y D2)
);

reg [3:0] units;  // Unidades (0-9)
reg [3:0] tens;   // Decenas (0-9)
reg [16:0] count; // Contador para el multiplexado
reg sel_display;  // Señal de selección para alternar entre displays (0=unidades, 1=decenas)



// División del número decimal en decenas y unidades
always @(*) begin
    tens = bin_in / 10;    // Decenas (división entera)
    units = bin_in % 10;   // Unidades (módulo de 10)
end



// Multiplexado: alternar entre los displays de unidades y decenas
always @(posedge clk) begin
    count <= count + 1;
    if (count == 100_000) begin  // Cambia de display cada 100,000 ciclos (ajustar según el reloj)
        sel_display <= ~sel_display;  // Alterna entre las unidades y las decenas
        count <= 0;
    end
end

// Mostrar el número correspondiente en el display de 7 segmentos
always @(*) begin
    if (sel_display == 1) begin
        // Mostrar las unidades
        sel = 4'b1110;  // Seleccionar el display de unidades (D1 activado)
        case (units)
            4'd0: seg_out = 7'b1111110; // 0
            4'd1: seg_out = 7'b0110000; // 1
            4'd2: seg_out = 7'b1101101; // 2
            4'd3: seg_out = 7'b1111001; // 3
            4'd4: seg_out = 7'b0110011; // 4
            4'd5: seg_out = 7'b1011011; // 5
            4'd6: seg_out = 7'b1011111; // 6
            4'd7: seg_out = 7'b1110000; // 7
            4'd8: seg_out = 7'b1111111; // 8
            4'd9: seg_out = 7'b1111011; // 9
            default: seg_out = 7'b0000000; // Apagado
        endcase
    end else begin
        // Mostrar las decenas
        sel = 4'b1101;  // Seleccionar el display de decenas (D2 activado)
        case (tens)
            4'd0: seg_out = 7'b1111110; // 0
            4'd1: seg_out = 7'b0110000; // 1
            4'd2: seg_out = 7'b1101101; // 2
            4'd3: seg_out = 7'b1111001; // 3
            4'd4: seg_out = 7'b0110011; // 4
            4'd5: seg_out = 7'b1011011; // 5
            4'd6: seg_out = 7'b1011111; // 6
            4'd7: seg_out = 7'b1110000; // 7
            4'd8: seg_out = 7'b1111111; // 8
            4'd9: seg_out = 7'b1111011; // 9
            default: seg_out = 7'b0000000; // Apagado
        endcase
    end
end
endmodule

