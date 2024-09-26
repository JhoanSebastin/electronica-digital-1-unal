import dht
import utime
import time
import machine
while True:
    led = machine.Pin(5, machine.Pin.OUT)  #Para mantener el encendido del diodo

    #Para lectura de datos de la temperatura
    #Los pines son 3v 16 y GND
    d = dht.DHT11(machine.Pin(16)) 
    d.measure()
    n= d.temperature() #nuemro a utilizar
    d.humidity()

    # Configuración de los GPIOs (7 pines para los 7 bits)
    gpio_pins = [33, 32, 27, 22, 21, 14, 12]  # Ajusta estos pines según tu placa

    # Configurar los pines GPIO como salidas
    pins = [machine.Pin(pin_number, machine.Pin.OUT) for pin_number in gpio_pins]
    print(pins)

    print("T= "+ str(n))
    print("H= " + str(d.humidity()))



    #Para convertir el valor en binario
    def decimal_to_7bits(n):
        if n > 99 or n < 0:
            raise ValueError("El número debe estar entre 0 y 99")
        
        # Convertir a binario y asegurar que tiene 7 bits
        binary_string = bin(n)[2:]
        bit_list = [bool(int(bit)) for bit in binary_string]
        
        # Rellenar a la izquierda con ceros para asegurarnos de que tiene 7 bits
        return [False] * (7 - len(bit_list)) + bit_list

    # Función para enviar los bits por GPIO
    def send_bits_to_gpio(bits, pins):
        for i in range(0,7):
            pins[i].value(bits[i])
            print(pins[i], pins[i].value())

            
    #Convertir el numero a una lista de bits boolenaos
    bits = decimal_to_7bits(n)
    print(decimal_to_7bits(n))
    # Enviar los bits por GPIO
    #send_bits_to_gpio(bits, pins)
    #print(send_bits_to_gpio(bits, pins))



    print("T= " + str(n))# + "H= " + str(d.humidity()))
        
    #Numero decimal
    print(bits)
    send_bits_to_gpio(bits, pins)
    utime.sleep(1)
    #Prender y apagar el led
    led.value(True)
    utime.sleep(1)
    led.value(False)
    utime.sleep(1)
