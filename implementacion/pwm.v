module top (
    input wire clk,           // Reloj del sistema
    input wire mq5_signal,    // Señal digital del sensor MQ-5 (1 = no humo, 0 = hay humo)
    output reg pwm_out        // Salida PWM para el parlante
);

reg [23:0] counter;            // Contador de 8 bits para el PWM
reg [7:0] duty_cycle;         // Duty cycle del PWM

always @(posedge clk) begin
    if (mq5_signal == 0) begin
        // No hay humo, el parlante no genera sonido (PWM apagado)
        pwm_out <= 0;
    end else begin
        // Hay humo, se activa el PWM con un ciclo de trabajo ajustado
        counter <= counter + 1;
        if (counter == duty_cycle)
            pwm_out <= 1;     // Activa el PWM
        else
            pwm_out <= 0;     // Desactiva el PWM
    end
end

// Configuramos el ciclo de trabajo para el PWM
initial begin
    duty_cycle = 8'd128;  // 50% de duty cycle (se puede ajustar según la intensidad del sonido)
end

endmodule
