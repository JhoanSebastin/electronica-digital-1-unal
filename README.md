# Sistema de alarma con FPGA



- [Ideación](./ideacion/README.md)

Este proyecto se centra en la integración de tres sensores y tres actuadores a través de una FPGA ICE40, que coordina y procesa los datos de cada sensor para generar respuestas específicas en los actuadores.  
Sensor de Temperatura: Procesado a través de un ESP32 para convertir los datos analógicos en binarios que la FPGA puede interpretar, para luego mostrarlos en un display de 7 segmentos.  
Sensor de Movimiento: Directamente conectado a la FPGA, controla un LED que parpadea durante un período de tiempo determinado al detectar movimiento.  
Sensor de Humo: También conectado directamente a la FPGA, genera una señal de modulación por ancho de pulso (PWM) que activa un parlante en caso de detectar humo. 

Sensor de Temperatura  el principal objetivo de este sensor es leer la temperatura ambiente y mostrarla en un display de 7 segmentos. este sensor se encarga de enviar los datos analogicos, para que el ESP32 los lee y los convierta en forma binaria, posteriormente la FPGA recibe estos datos en binario, dentro se implementa un decodificador binario a decimal, con el fin de convertirlo a un formato que pueda leer el 7 segmentos.  Cabe recalcar que el ESP32 debe estar configurado de tal forma que periodicamnte leea los datos del sensor, por si la temperatura esta cambiando.  
Sensor de movimiento: La idea es que este sensor detecte el movimiento y pueda hacer que el led parpadee cuando hay un alto, el sensor pir se conecta directamente a la FPGA, este envia una señal alta(1) cuando detecta movimiento y baja (0) cuando no. Al recibir esta señal la fpga debe activar un contador, el cual controla la duracion del blink, por lo que el led debe estar prendido durante cierto tiempo y apagado despues.  El circuito debe incluir un modo secuencial el que inicia el parpadeo, cuando la señal del pir esta activa.  
Sensor de humo:  Esta parte debe detectar el humo y activar el parlante con una señal pwm.El sensor MQ-5 se conecta directamnete a la fpga, cuando detecta humo genera una señal (0) y cunado no hay humo (1).Cunado la fpga recibe la señal genera una señal por modulacion que se debe enviar al parlante , esta señal debe tener una frecuancia que se pueda escuchar al oido humano. La idea es que cuneta con un multiplexor que se encarga de activar o desactivar el pwm dependiendo de la señal que entre. 

La FPGA se encarga de interconectar todo , por lo que los  3 sensores deben ir conectadas a las entradas de  la fpga y las salidas son los actuadores, se debe diseñar el codigo para que las tareas necesarias se hagan simultaneamente. Asi mismo se encarga del clock para sincronizar las operaciones de todos los bloques El reloj controla los contadores de tiempo (para el parpadeo del LED y el PWM) y la frecuencia de actualización de las señales que vienen del ESP32 para el display de 7 segmentos.  
Los 3 sensores utilizados son los siguientes:  
Sensor de temperatura (DHT11)  
Sensor de Movimiento (Sensor Pir)  
Sensor de Humo (MQ-5)  
En los actuadores se usaron los siguientes componentes:  
7 segmentos ( muestra la temperatura )  
Buzzer (Se activa cuada vez que el sensor detecta humo )  
Led (cunado hay movimineto el led se apaga y se prende )  
 
- [Diseño](./diseño/README.md)  

Entradas  
Sensor de movimiento ("1" y "0")  
Sensor de humo ("1" y "0")  
Sensor de temperatura (SDA, SCL)  

Salidas  
Led (Digital 0v a 5 V)  
7 segmentos (12 salidas digitales)  
Buzzer (3v a 10v)  
# Diagrama proyecto  
![Diagrama del proyecto](https://github.com/JhoanSebastin/electronica-digital-1-unal/blob/main/Diagrama%20proyecto.jpg)  
# Diagrama de flujo  
![Diagrama de flujo](https://github.com/JhoanSebastin/electronica-digital-1-unal/blob/main/Diagrama%20de%20flujo.jpg)  
# Diagrama para el 7 segmentos  
![Diagrama de 7 segmentos](https://github.com/JhoanSebastin/electronica-digital-1-unal/blob/main/Diagrama%207%20.jpg)  
# Diagrama RTL para el 7 segmentos  
![RTLde 7 segmentos](https://github.com/JhoanSebastin/electronica-digital-1-unal/blob/main/Diagrama%207%20rl.jpg)  
# Diagrama RTL Blink 
![RTLdel Blink](https://github.com/JhoanSebastin/electronica-digital-1-unal/blob/main/blink%20rtl.jpg)  
# Diagrama RTL para el PWM 
![RTLde PWM](https://github.com/JhoanSebastin/electronica-digital-1-unal/blob/main/pwm%20rtl.jpg)

- [Implementación](./implementacion/README.md)
A continuacion encontrara los codigos utilizados:  
- [Codigo 7 segmentos](./7segmentos.v)  
- [Codigo ESP32](./ESP32.py)
- [Codigo entradas temperatura](./top.pcf)  
- [Codigo PWM](./pwm.v)
- [Codigo entradas PWM](./entradaspwm.pcf)
- [Codigo Blink](./BLINK.v)

# Evidencias 
Acontinuacion encontrara algunos videos del funcionamiento del sistema de alarma:  
[Funcionamiento 7 segmentos](https://www.youtube.com/shorts/RXIc9Svriqs)  
[Funcionamiento Blink](https://www.youtube.com/shorts/WwuvhLxpkaU)






