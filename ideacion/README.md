# Ideacion  

Este proyecto se centra en la integración de tres sensores y tres actuadores a través de una FPGA ICE40, que coordina y procesa los datos de cada sensor para generar respuestas específicas en los actuadores.  
Sensor de Temperatura: Procesado a través de un ESP32 para convertir los datos analógicos en binarios que la FPGA puede interpretar, para luego mostrarlos en un display de 7 segmentos.  
Sensor de Movimiento: Directamente conectado a la FPGA, controla un LED que parpadea durante un período de tiempo determinado al detectar movimiento.  
Sensor de Humo: También conectado directamente a la FPGA, genera una señal de modulación por ancho de pulso (PWM) que activa un parlante en caso de detectar humo. 

Sensor de Temperatura  el principal objetivo de este sensor es leer la temperatura ambiente y mostrarla en un display de 7 segmentos. este sensor se encarga de enviar los datos analogicos, para que el ESP32 los lee y los convierta en forma binaria, posteriormente la FPGA recibe estos datos en binario, dentro se implementa un decodificador binario a decimal, con el fin de convertirlo a un formato que pueda leer el 7 segmentos.  



