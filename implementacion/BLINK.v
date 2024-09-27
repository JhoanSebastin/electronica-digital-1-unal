module top(
    input wire clk,            // Señal de reloj de 25 MHz
    input wire signal_in,       // Señal de entrada (activa en alto)
    output reg led              // Salida para el LED
);

    reg [24:0] counter;        // Contador para los ciclos de reloj (25 MHz)
    reg [2:0] blink_counter;   // Contador para llevar el tiempo del parpadeo (5 segundos)
    reg blink_active;          // Señal para activar el parpadeo
    reg led_state;             // Estado actual del LED (encendido o apagado)

    // Parámetro para definir 1 segundo (25 millones de ciclos para un reloj de 25 MHz)
    parameter ONE_SECOND = 20_000_000;

    always @(posedge clk) begin
        if (signal_in) begin
            if (!blink_active) begin
                // Si la señal está en alto y el parpadeo no está activo, lo activamos
                blink_active <= 1;
                counter <= 0;
                blink_counter <= 0;
                led_state <= 1;
            end else if (counter == ONE_SECOND - 1) begin
                // Cada segundo alternamos el estado del LED
                counter = 0;
                led_state = ~led_state;
                
                // Incrementamos el contador de parpadeos
                if (blink_counter < 5) begin
                    blink_counter <= blink_counter + 1;
                end else begin
                    // Si han pasado 5 segundos, desactivamos el parpadeo
                    blink_active = 0;
                    led_state = 0;
                end
            end else begin
                // Seguimos contando
                counter = counter + 1;
            end
        end else begin
            // Si la señal no está en alto, apagamos el LED y reiniciamos
            led_state = 0;
            blink_active = 0;
        end
    end

    // Asignamos el estado del LED a la salida
    assign led = led_state;

endmodule
