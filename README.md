# Sistema de alarma con FPGA

# Ideacion 

Para este proycto se tuvo la idea de hacer un sistema de alarma con 3 sensores y 3 actuadores. A continuacion se buscaron los sensores necesarios para la implementacion como los son:  
Sensor de temperatura (DHT11)  
Sensor de Movimiento (Sensor Pir)  
Sensor de Humo (MQ-5)  
Estos sensores se van a conectar con la FPGA, por lo que surgieron problemas, uno de ellos es la conexion del sensor DHT11 con la FPGA, ya que el sensor trabaja con una señal I2C que no puedo leer la FPGA, por lo que se opto por usar un ESP32, Los datos que manda el sensor se reciben en el ESP32 con microPyhton, este se encarga de convertirlo a binario para finalmente pasarlos a la FPGA. Con los demas sensores no se tiene que hacer uso de ningun componente mas ya que estos ya trbajan en binario.


En los actuadores se usaron los siguientes componentes:
7 segmentos ( muestra la temperatura )
Buzzer (Se activa cuada vez que el sensor detecta humo )
Led (cunado hay movimineto el led se apaga y se prende )

El funcionamiento del protyecto  es el siguiente:
Cuando el sensor de temperatura funciona este envia los datos a la ESP32, el cual lee los datos (I2C) y con un codigo que se implementa en micropython los convierte a binario, Este codigo si lo puede leer la FPGA, la fpga convierte el codigo para que el 7 segmentos funcione y muestre la temperatura. En el caso de el sensor de movimineto, este solo envia unos y ceros ,por lo que no hay necesidad de la ESP32, se conecta directamente a la FPGA y se diseña un blink para que cuando detecte movimiento el led parpadee. Por ulltmo el sensor de humo funciona muy parecido al de movimiento, solo envia unos y ceros y cundo la fpga los lee, activa el buzzer si  recibe un alto.

# Diseño 

Entradas
Sensor de movimiento ("1" y "0")
Sensor de humo ("1" y "0")
Sensor de temperatura (SDA, SCL)

Salidas 



