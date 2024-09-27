module top (
    input wire [6:0] bin_in,          // Entrada: número binario de 7 bits (0-99)
    input clk,                   // Señal de reloj
    output reg [6:0] seg_out,    // Salida: segmentos para el display de 7 segmentos
    output reg [3:0] sel         // Selección del display (para alternar entre D1 y D2)
);

reg [3:0] units;  // Unidades (0-9)
reg [3:0] tens;   // Decenas (0-9)
reg [16:0] count; // Contador para el multiplexado
reg sel_display; //= 1;  // Señal de selección para alternar entre displays (0=unidades, 1=decenas)



// División del número decimal en decenas y unidades
always @(*) begin
    tens = bin_in / 10;    // Decenas (división entera)
    units = bin_in % 10;   // Unidades (módulo de 10)
end



// Multiplexado: alternar entre los displays de unidades y decenas
always @(posedge clk) begin
    count <= count + 1;
    if (count == 50000) begin  // Cambia de display cada 100,000 ciclos (ajustar según el reloj)
        sel_display <= ~sel_display;  // Alterna entre las unidades y las decenas
        count <= 0;
    end else begin
		count <= count + 1;
	end
end

// Mostrar el número correspondiente en el display de 7 segmentos
always @(*) begin
    if (sel_display == 1) begin
        // Mostrar las unidades
        sel = 4'b0001;  // Seleccionar el display de unidades (D1 activado)
        case (units)
            4'd0: seg_out = 7'b0000001; // 0
            4'd1: seg_out = 7'b1001111; // 1 7'b0110000
            4'd2: seg_out = 7'b0010010; // 2 7'b1101101
            4'd3: seg_out = 7'b0000110; // 3 7'b1111001
            4'd4: seg_out = 7'b1001100; // 4 7'b0110011
            4'd5: seg_out = 7'b0100100; // 5 7'b1011011
            4'd6: seg_out = 7'b0100000; // 6 7'b1011111
            4'd7: seg_out = 7'b0001111; // 7 7'b1110000
            4'd8: seg_out = 7'b0000000; // 8 7'b1111111
            4'd9: seg_out = 7'b0000100; // 9 7'b1111011
            default: seg_out = 7'b11111111; // Apagado eran ceros
        endcase
    end else begin
        // Mostrar las decenas
        sel = 4'b0010;  // Seleccionar el display de decenas (D2 activado)
        case (tens)
            4'd0: seg_out = 7'b0000001; // 0
            4'd1: seg_out = 7'b1001111; // 1 7'b0110000
            4'd2: seg_out = 7'b0010010; // 2 7'b1101101
            4'd3: seg_out = 7'b0000110; // 3 7'b1111001
            4'd4: seg_out = 7'b1001100; // 4 7'b0110011
            4'd5: seg_out = 7'b0100100; // 5 7'b1011011
            4'd6: seg_out = 7'b0100000; // 6 7'b1011111
            4'd7: seg_out = 7'b0001111; // 7 7'b1110000
            4'd8: seg_out = 7'b0000000; // 8 7'b1111111
            4'd9: seg_out = 7'b0000100; // 9 7'b1111011
            default: seg_out = 7'b11111111; // Apagado eran ceros
        endcase
    end
end
endmodule
