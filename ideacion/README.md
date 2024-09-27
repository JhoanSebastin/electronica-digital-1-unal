# Ideacion  

Este proyecto se centra en la integración de tres sensores y tres actuadores a través de una FPGA ICE40, que coordina y procesa los datos de cada sensor para generar respuestas específicas en los actuadores.  
Sensor de Temperatura: Procesado a través de un ESP32 para convertir los datos analógicos en binarios que la FPGA puede interpretar, para luego mostrarlos en un display de 7 segmentos.  
Sensor de Movimiento: Directamente conectado a la FPGA, controla un LED que parpadea durante un período de tiempo determinado al detectar movimiento.  
Sensor de Humo: También conectado directamente a la FPGA, genera una señal de modulación por ancho de pulso (PWM) que activa un parlante en caso de detectar humo.    
Sensor de Temperatura  


